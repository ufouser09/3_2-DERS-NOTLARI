#include <stdio.h>
int main(){
	double x=20,x0=2;
	double h=0.1;
	int steps;
	steps = (int)((float)(x - x0) / h);
	
	printf("%d",steps);
}
