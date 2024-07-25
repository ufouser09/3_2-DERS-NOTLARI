#include <stdio.h>
#include <stdlib.h>

// Diferansiyel denklemin katsay�lar�n� saklayacak yap�
typedef struct {
    int order;       // Denklemin mertebesi
    double *coeffs;  // Katsay�lar dizisi
} DiffEq;

// Diferansiyel denklemin sa� taraf�n� hesaplayan fonksiyon
double f(double t, double y[], DiffEq eq) {
    double result = 0.0;
    for (int i = 0; i <= eq.order; i++) {
        result += eq.coeffs[i] * y[i];
    }
    return result;
}

// Runge-Kutta 4. mertebe y�ntemi
void RK4(double t0, double y0[], double t, double h, DiffEq eq) {
    int steps = (int)((t - t0) / h);
    double y[eq.order + 1];
    for (int i = 0; i <= eq.order; i++) {
        y[i] = y0[i];
    }

    for (int i = 0; i < steps; i++) {
        double k1 = h * f(t0, y, eq);
        double k2 = h * f(t0 + 0.5 * h, y, eq);
        double k3 = h * f(t0 + 0.5 * h, y, eq);
        double k4 = h * f(t0 + h, y, eq);

        y[0] = y[0] + (k1 + 2*k2 + 2*k3 + k4) / 6;
        t0 += h;

        printf("Ad�m %d: Yakla��k de�er = %lf\n", i, y[0]);
    }

    printf("��z�m: t = %lf i�in y = %lf\n", t, y[0]);
}

int main() {
    int n;
    printf("Denklemin mertebesi (n): ");
    scanf("%d", &n);

    DiffEq eq;
    eq.order = n;
    eq.coeffs = (double *)malloc((n + 1) * sizeof(double));

    printf("Katsay�lar� girin:\n");
    for (int i = 0; i <= n; i++) {
        printf("Katsay� %d: ", i);
        scanf("%lf", &eq.coeffs[i]);
    }

    double t0 = 0, t, h = 0.1;
    double y0[n + 1];
    y0[0] = 1; // Ba�lang�� de�eri

    printf("Ba��ms�z de�i�kenin de�eri (t veya x): ");
    scanf("%lf", &t);

    RK4(t0, y0, t, h, eq);

    free(eq.coeffs);
    return 0;
}

