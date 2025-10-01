# Interpolation

Implementations of the following interpolation methods:

- **1D Nearest Neighbor Interpolation** (in Matlab and Python)
- **1D Linear Interpolation** (in Matlab and Python)
- **1D Lagrange Interpolation** (in Matlab and Python)
- **1D Cubic Spline Interpolation** (in Matlab and Python)

The codes are designed for educational purposes only. 

---

## 📐 Mathematical Background

Given:
- a set of uniformly spaced sample points:
  
  $$x = \{x_1, x_2, \dots, x_N\}, \quad x_i = x_1 + (i-1)h, \quad i=1,\ldots,N, \quad h = x_{i+1} - x_i$$
  
- corresponding sample values:
  
  $$y = \{y_1, y_2, \dots, y_N\}, \quad y_i = f(x_i)$$

- a set of interpolation points

  $$\xi = \{\xi_1, \xi_2, \dots, \xi_M\}$$,

we want to estimate the function values $f(\xi_j)$.

---

### 🔹 Nearest Neighbor Interpolation (Piecewise Constant Approximation)

For each interpolation point $\xi$, find the nearest sample index:

$$i = \text{round}\left(\frac{\xi - x_1}{h}\right) + 1$$

The interpolated value is:

$$f(\xi) \approx y_i$$

---

### 🔹 Linear Interpolation (Piecewise Linear Approximation)

For each query point $\xi$, find the nearest left neighbor:

$$i = \left\lfloor \frac{\xi - x_1}{h} \right\rfloor + 1$$

Define the local interpolation weight:

$$\alpha = \frac{\xi - x_i}{h} \quad \alpha \in [0,1]$$

Then the interpolated value is:

$$f(\xi) \approx (1 - \alpha)y_i + \alpha y_{i+1}$$

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

### 🔹 Cubic Spline Interpolation

Cubic spline interpolation constructs a smooth function $g(x)$ that satisfies the following properties:

- $g(x)$ is a **piecewise cubic polynomial**:  
  On each interval $(x_{k-1}, x_k)$,  
  $$g(x) = a_k + b_k(x-x_{k-1}) + c_k(x-x_{k-1})^2 + d_k(x-x_{k-1})^3.$$

- $g(x)$ interpolates the data:  
  $$g(x_k) = y_k, \quad k = 0, 1, \dots, N.$$

- $g(x)$ has continuous first and second derivatives:  
  $$g(x) \in C^{2}(a, b).$$

- **Natural boundary conditions** are enforced:  
  $$g''(a) = g''(b) = 0.$$

This ensures a smooth and stable approximation that avoids the oscillatory artifacts often seen in high-degree polynomial interpolation.

---

### 🔹 Cubic Spline Interpolation

Cubic spline interpolation constructs a smooth function $g(x)$ that satisfies:

- $g(x)$ is a **piecewise cubic polynomial**:  
  On each interval $(x_{k-1}, x_k)$,  
  $$g(x) = a_k + b_k(x-x_{k-1}) + c_k(x-x_{k-1})^2 + d_k(x-x_{k-1})^3.$$

- $g(x)$ interpolates the data:  
  $$g(x_k) = y_k, \quad k = 0, 1, \dots, N.$$

- $g(x)$ has continuous first and second derivatives:  
  $$g(x) \in C^{2}(a, b).$$

- **Natural boundary conditions** are imposed:  
  $$g''(a) = g''(b) = 0.$$

---

#### Computation of coefficients

To compute the spline coefficients, the **second derivatives at the knots** are first determined.  
This is achieved by solving a **tridiagonal linear system** of the form:

$$
A \mathbf{m} = \mathbf{b},
$$

where $\mathbf{m} = \{g''(x_1), \dots, g''(x_{N-1})\}$ are the unknown second derivatives at interior points.  
The matrix $A$ is tridiagonal because each spline segment only couples with its immediate neighbors.  

Once $\mathbf{m}$ is obtained, the coefficients are computed as:

- $a_k = y_{k}$  
- $b_k = \dfrac{y_{k+1}-y_k}{h_k} - \dfrac{h_k}{6}\left(2m_k + m_{k+1}\right)$  
- $c_k = \dfrac{m_k}{2}$  
- $d_k = \dfrac{m_{k+1} - m_k}{6h_k}$  

with $h_k = x_{k+1}-x_k$.  

This procedure ensures a stable, smooth interpolant that avoids oscillations often encountered in high-degree polynomial interpolation.

