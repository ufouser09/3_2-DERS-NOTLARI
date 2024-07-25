#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
typedef struct D�F{
	int mertebe;
	int *katSayi;
	
};


int main(){
	int N,M,cevap,durum;
	double x0,x,h;
	double y0[N+1];
	D�F eq;
	
	
	printf("denklemin mertebesini giriniz\n");
	scanf("%d",&N);
	
	printf("artis miktarini giriniz\n");
	scanf("%lf",&h);
	
	printf("lutfen X'in baslangic degerini(initial value)giriniz\n");
	scanf("%lf",&x0);
	
	printf("lutfen G(x) ifademizin kac terimden olusacagini giriniz\n");
	scanf("%d",&M);
	
	printf("lutfen hedef degeri(TARGET VALUE)giriniz\n");
	scanf("%lf",x)
	
	eq.mertebe=N;
	eq.katSayi=(int*)malloc((N+1)*sizeof(int));
	if(eq.katSayi==NULL){
		printf("ERROR!\n");
		return -1;
	}
	else{
		printf("lutfen Y'li ifadelerin katsayilarini giriniz\n");
		for(i=0;i<N+1;i++){
			printf("Ay'+By+c=G(x) ifademizin %d.teriminin katsayisini giriniz\n");
			scanf("%d",&eq.katSayi[i]);
		}
		for(i=0;i<N+1;i++){
			printf("Ay'+By+c=G(x) ifademizin %d.teriminin Y ifadesinin baslangic degerini giriniz\n");
			scanf("%lf",&y0[i]);
		}
		
	}
	RK4(x0,y0[],x,h,eq,M);
	
}
//X'in baslangic degerine hep h artt�r�p buraya gelip hesaplat�cam
double denklemHesaplaX(double x,int M){
	
	
	int durum,cevap,yanit;
	int trigo_katsayi,trigo_ickatsayi,ln_katsayi,ln_ickatsayi,e_katsayi,e_ustkatsayi;
	double deger[M],toplam=0;
	
		durum=0;
		cevap=0;
		yanit=0;
		while(durum<M){
		printf("%d. X'li ifadenizde\n",durum+1);
		
		
		printf("\nTrigonometrik degisken var mi?");//trigonometrik degisken olup olmad�g�na bak bunu kullaniciya sor
		printf("\n1) Var.   2) Yok.\n");
		scanf("%d", &cevap);	
		
		printf("\nTrigonometrik degiskenin S�N ise 1,COS ise 2,TAN ise 3,COT ise 4' bas");
		scanf("%d",&yanit);
		
		if(cevap==1 && yanit==1){
			printf("lutfen trigonometrik ifadenin katsayisini giriniz");
			scanf("%d",&trigo_katsayi);
			
			printf("lutfen trigonometrik ifadenin ickatsayisini giriniz\n");
			scanf("%d",&trigo_ickatsayi);
			
			deger[durum]=trigo_katsayi*sin(trigo_ickatsayi);
			
			
		}
		else if(cevap==1 && yanit==2){
			printf("lutfen trigonometrik ifadenin katsayisini giriniz");
			scanf("%d",&trigo_katsayi);
			
			printf("lutfen trigonometrik ifadenin ickatsayisini giriniz\n");
			scanf("%d",&trigo_ic_katsayi);
			
			deger[durum]=trigo_katsayi*cos(trigo_ickatsayi);
		}
		else if(cevap==1 && yanit==3){
			printf("lutfen trigonometrik ifadenin katsayisini giriniz");
			scanf("%d",&trigo_katsayi);
			
			printf("lutfen trigonometrik ifadenin ickatsayisini giriniz\n");
			scanf("%d",&trigo_ic_katsayi);
			
			deger[durum]=trigo_katsayi*tan(trigo_ickatsayi);
			
		}
		else if(cevap==1 && yanit==4){
			printf("lutfen trigonometrik ifadenin katsayisini giriniz");
			scanf("%d",&trigo_katsayi);
			
			printf("lutfen trigonometrik ifadenin ickatsayisini giriniz\n");
			scanf("%d",&trigo_ic_katsayi);
			
			deger[durum]=trigo_katsayi/(tan(trigo_ickatsayi));
			
		}
		
		printf("\nlnx degiskeni var mi?");
		printf("\n1) Var.   2) Yok.\n");
		scanf("%d", &cevap);
		if(cevap==1){
			printf("lnx'li ifademizin katsayisini giriniz\n");
			scanf("%d",&ln_katsayi);
			printf("lnx'li ifademizin ic katsayisini giriniz\n");
			scanf("%d",&ln_ickatsayi);
			
			deger[durum]=ln_katsayi*log(ln_ickatsayi*x);
			
		}
		printf("\ne^x degiskeni var mi?");//cumlede e li bir ifade olup olmad�g�n� sor
		printf("\n1) Var.   2) Yok.\n");
		scanf("%d", &cevap);
		if(cevap==1){
			printf("lutfen e^x'in katsayisini giriniz\n");
			scanf("%d",&e_katsayi);
			printf("lutfen e^x'in �st katsayisini giriniz\n");
			scanf("%d",&e_ustkatsayi);
			
			deger[durum]=e_katsayi*pow(E,e_ustkatsayi);
		}
		printf("\nNormal X degiskeni var mi?");
		printf("\n1)Var.		2)Yok.");
		scanf("%d",&cevap);
		if(cevap==1){
			printf("lutfen katsayisini giriniz\n");
			scanf("%d",&x_katsayi);
			
			printf("lutfen �ss�n� giriniz");
			scanf("%d",&x_ustkatsayi);
			
			deger[durum]=x_katsayi*pow(x,x_ustkatsayi);
		}
		
		
		toplam+=deger[durum];
		
		
		
		durum++;
	}
	return toplam;
}

void RK4(double x0, double y0[], double x, double h, D�F eq,int M) {
    int steps = (int)((x - x0) / h);
    int xson=0;
    double sonuc1,sonuc2;

    for (int i = 0; i < steps; i++) {
        xson=x0+h;
        sonuc1=denklemHesaplaX(xson,M);
        sonuc2=f(y0[],eq);
        
        /*
		double k1 = h * f(t0, y, eq);
        
        double k2 = h * f(t0 + 0.5 * h, y, eq);
        
		double k3 = h * f(t0 + 0.5 * h, y, eq);
        
		double k4 = h * f(t0 + h, y, eq);

        y[0] = y[0] + (k1 + 2*k2 + 2*k3 + k4) / 6;
        t0 += h;

        printf("Ad�m %d: Yakla��k de�er = %lf\n", i, y[0]);
        */
    }

    printf("��z�m: t = %lf i�in y = %lf\n", t, y[0]);
}
double f(double x, double y0[], DiffEq eq) {
    double result = 0.0;
    for (int i = 0; i <= eq.order; i++) {
        result += eq.katsayi[i] * y0[i];
    }
    return result;
}





