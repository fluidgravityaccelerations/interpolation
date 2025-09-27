# Interpolation

This repository provides implementations of the following interpolation methods:

- **Nearest Neighbor** (in Matlab and Python)
- **Linear** (in Matlab and Python)

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

For each query point \( \xi \), find the nearest sample index:

\[
i = \text{round}\!\left(\frac{\xi - x_1}{h}\right) + 1
\]

The interpolated value is:

\[
f(\xi) \approx y_i
\]

This method produces a **piecewise constant approximation**.

---

### 🔹 Linear Interpolation

# Interpolation

For each query point \( \xi \), find the nearest left neighbor:

$$i = \left\lfloor \frac{\xi - x_1}{h} \right\rfloor + 1$$

Define the local interpolation weight:

\[
\alpha = \frac{\xi - x_i}{h}, \quad \alpha \in [0,1]
\]

Then the interpolated value is:

\[
f(\xi) \approx (1 - \alpha)\,y_i + \alpha\,y_{i+1}
\]

This produces a **piecewise linear approximation**.

---

## 📄 Functions

### `nearestNeighborInterpolation1D.m`
```matlab
function yi = nearestNeighborInterpolation1D(x, y, xi)
    h   = x(2) - x(1);                        % uniform spacing
    idx = round((xi - x(1)) / h) + 1;         % nearest index
    idx = min(max(idx, 1), numel(x));         % clamp to [1, numel(x)]
    yi  = y(idx);                             % direct lookup
end
