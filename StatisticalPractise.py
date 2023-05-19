#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri May 19 18:54:06 2023

@author: maheshg
"""

import numpy as np

a = np.array([1,2,3])

print(type(a))

print(np.shape(a))

b = np.array([[1,2],[3,4]])

print(type(b))

print(np.shape(b))

print(b)

b[1,0]

c = np.zeros((3,2))

print(c)

d = np.ones((3,2))

print(d)

e = np.full((3,3),9)

print(e)

f = np.random.random((3,3))

print(f)

###Index Array : 
g = np.array([[1,2,3,4],[5,6,7,8],[9,10,11,12]])

print(g)

g = g[:2,1:3]

print(g)

###Index Array : 
h = np.array([[1,2,3,4],[5,6,7,8],[9,10,11,12]])

i = h[:2,1:3]

print(i)

i[0,0] = 500

print(h)


j = np.array([1,2])
print(j.dtype)

k = np.array([1.0,3.0,5.3])
print(k.dtype)

l = np.array([1.0,3.5,5.7], dtype = np.int64)
print(l.dtype)

x = np.array([[1,2],[4,5]], dtype = np.float64)
y = np.array([[1,3],[7,8]], dtype = np.float64)

print( x + y)
print(x-y)
print(x*y)
print(x/y)
print(np.sqrt(x))