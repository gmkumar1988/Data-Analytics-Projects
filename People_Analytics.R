install.packages(c("gtrendsR","tidymodels","modeltime","tidyverse","timetk","lubridate","flextable"))

# Libraries
library(gtrendsR)
library(tidymodels)
library(modeltime)
library(tidyverse)
library(timetk)
library(lubridate)
library(flextable)

# Google Trends Parameters

search_term   <- "people analytics"
location      <- "" # global
time          <- "2010-01-01 2020-08-01" # uses date format "Y-m-d Y-m-d"
gprop         <- "web"

# Google Trends Data Request

gtrends_result_list <- gtrendsR::gtrends(
  keyword = search_term,
  geo     = location,
  time    = time,
  gprop   = gprop
  
)

# Data Cleaning

gtrends_search_tbl <- gtrends_result_list %>%
  pluck("interest_over_time") %>%
  as_tibble() %>%
  select(date, hits) %>%
  mutate(date = ymd(date)) %>%
  rename(value = hits)

# Visualization of Google Trends Data

gtrends_search_tbl %>%
  timetk::plot_time_series(date, value)


# Train/Test
k <- 18


no_of_months <-
  lubridate::interval(base::min(gtrends_search_tbl$date),
                      base::max(gtrends_search_tbl$date)) %/%
  base::months(1)

prop <- (no_of_months - k) / no_of_months


splits <- rsample::initial_time_split(gtrends_search_tbl, prop = prop)


splits %>%
  tk_time_series_cv_plan() %>%
  plot_time_series_cv_plan(date, value)

#Model 1 : Exponential Smoothing 
model_fits_ets <- modeltime::exp_smoothing() %>% 
    parsnip::set_engine(engine = "ets") %>%
  parsnip::fit(value ~ date, data = training(splits))


#Model 2 : ARIMA 

model_fits_arima <- modeltime::arima_reg() %>% 
  parsnip::set_engine("auto_arima") %>%
  parsnip::fit(value ~ date, data = training(splits))

#Model 3 : ARIMA BOOST

model_fits_arima_boost <- modeltime::arima_boost() %>%
  parsnip::set_engine("auto_arima_xgboost") %>%
  parsnip::fit(value ~ date + as.numeric(date) + month(date, label = TRUE), data = training(splits))


#Model 4 : PROPHET

model_fits_propher <- modeltime::prophet_reg() %>% 
  parsnip::set_engine("prophet") %>% 
  parsnip::fit(value ~ date, data = training(splits))


#Model 5 : PROPHET BOOST

model_fit_prophet_boost <- modeltime::prophet_boost() %>%
  parsnip::set_engine("prophet_xgboost") %>%
  parsnip::fit(value ~ date + as.numeric(date) + month(date, label = TRUE),
               data = training(splits))
#Model Time 
model_tbl <- modeltime_table(model_fits_ets,
                             model_fits_arima,
                             model_fits_arima_boost,
                             model_fits_propher,
                             model_fit_prophet_boost )

#Calibrate the model accuracy
calibration_tbl <- model_tbl %>%
  modeltime_calibrate(testing(splits))


calibration_tbl %>% 
  modeltime_accuracy() %>%
  flextable() %>%
  bold(part = "header") %>%
  bg(bg = "#D3D3D3", part = "header") %>%
  autofit()


refit_tbl <- calibration_tbl %>%
  modeltime_refit(data = gtrends_search_tbl)

forecast_tbl <- refit_tbl %>%
  modeltime_forecast(h = "1 year",actual_data = gtrends_search_tbl, conf_interval = 0.90)

forecast_tbl %>%
  plot_modeltime_forecast(.interactive = TRUE)


mean_forecast_tbl <- forecast_tbl %>%
  filter(.key != "actual") %>%
  group_by(.key,.index) %>%
  summarise(across(.value:.conf_hi,mean)) %>%
  mutate(.model_id = 6, .model_desc = "Average Of Models")


forecast_tbl %>% filter(.key == "actual") %>%
  bind_rows(mean_forecast_tbl) %>%
  plot_modeltime_forecast()
 



