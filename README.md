# Interpolation

This repository provides implementations of the following interpolation methods:

- **1D Nearest Neighbor** (in Matlab and Python)
- **1D Linear** (in Matlab and Python)
- **1D Lagrange Interpolation** (in Matlab and Python)
- **1D Cubic Spline Interpolation** (in Matlab and Python)

The codes are designed for educational purposes only. 

---

## 📐 Mathematical Background

Given:
- a set of uniformly spaced sample points:
  
  $$x = \{x_1, x_2, \dots, x_N\}, \quad x_i = x_1 + (i-1)h, \quad h = x_{i+1} - x_i$$
  
- corresponding sample values:
  
  $$y = \{y_1, y_2, \dots, y_N\}, \quad y_i = f(x_i)$$

- a set of query points

  $$\xi = \{\xi_1, \xi_2, \dots, \xi_M\}$$,

we want to estimate the function values $f(\xi_j)$.

---

### 🔹 Nearest Neighbor Interpolation

For each query point $\xi$, find the nearest sample index:

$$i = \text{round}\left(\frac{\xi - x_1}{h}\right) + 1$$

The interpolated value is:

$$f(\xi) \approx y_i$$

This method produces a **piecewise constant approximation**.

---

### 🔹 Linear Interpolation

For each query point $\xi$, find the nearest left neighbor:

$$i = \left\lfloor \frac{\xi - x_1}{h} \right\rfloor + 1$$

Define the local interpolation weight:

$$\alpha = \frac{\xi - x_i}{h} \quad \alpha \in [0,1]$$

Then the interpolated value is:

$$f(\xi) \approx (1 - \alpha)y_i + \alpha y_{i+1}$$

This produces a **piecewise linear approximation**.

---

### 🔹 Lagrange Polynomial Interpolation

The interpolant is defined as the unique polynomial of degree at most $N-1$ that passes through all sample points:

$$
P(x) = \sum_{i=1}^N y_i \, L_i(x),
$$

where $L_i(x)$ are the **Lagrange basis polynomials**:

$$
L_i(x) = \prod_{\substack{j=1 \\ j \neq i}}^N \frac{x - x_j}{x_i - x_j}.
$$

Thus, $P(x_j) = y_j$ exactly.

While Lagrange interpolation is mathematically exact for polynomials up to degree $N-1$, **numerical instability** may occur for oscillatory functions. The examples provided include a case where interpolation of $\sin(5x)$ with $50$ nodes produces oscillations and artifacts, highlighting this instability.

---
