#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#define E 2.876
typedef struct Dif{
	int mertebe;
	int *katSayi;
	
}DIF;
double denklemHesaplaX(double x,int M);
void RK4(double x0, double y0[], double x, double h, DIF eq,int M);
double f(double x,double y0[], DIF eq);


int main(){
	int N,M,cevap,durum,i;
	double x0,x,h;
	double y0[N+1];
	DIF eq;
	
	
	printf("denklemin mertebesini giriniz\n");
	scanf("%d",&N);
	
	printf("artis miktarini giriniz\n");
	scanf("%lf",&h);
	
	printf("lutfen X'in baslangic degerini(initial value)giriniz\n");
	scanf("%lf",&x0);
	
	printf("lutfen G(x) ifademizin kac terimden olusacagini giriniz\n");
	scanf("%d",&M);
	
	printf("lutfen hedef degeri(TARGET VALUE)giriniz\n");
	scanf("%lf",&x);
	
	eq.mertebe=N;
	eq.katSayi=(int*)malloc((N+1)*sizeof(int));
	if(eq.katSayi==NULL){
		printf("ERROR!\n");
		return -1;
	}
	else{
		printf("lutfen Y'li ifadelerin katsayilarini giriniz\n");
		for(i=0;i<N+1;i++){
			printf("Ay'+By+c=G(x) ifademizin %d.teriminin katsayisini giriniz\n",i);
			scanf("%d",&eq.katSayi[i]);
		}
		for(i=0;i<N;i++){
			printf("Ay'+By+c=G(x) ifademizin %d.teriminin Y ifadesinin baslangic degerini giriniz\n",i);
			scanf("%lf",&y0[i]);
		}
		
	}
	printf("%lf",x);
	RK4(x0,y0,x,h,eq,M);
	
	
}
//X'in baslangic degerine hep h arttýrýp buraya gelip hesaplatýcam
double denklemHesaplaX(double x,int M){
	
	
	int durum,cevap,yanit;
	int trigo_katsayi,trigo_ickatsayi,ln_katsayi,ln_ickatsayi,e_katsayi,e_ustkatsayi,x_katsayi,x_ustkatsayi;
	double deger[M],toplam=0;
	
		durum=0;
		cevap=0;
		yanit=0;
		
		while(durum<M){
		printf("%d. X'li ifadenizde\n",durum);
		
		
		printf("\nTrigonometrik degisken var mi?");//trigonometrik degisken olup olmadýgýna bak bunu kullaniciya sor
		printf("\n1) Var.   2) Yok.\n");
		scanf("%d", &cevap);	
		
		if(cevap==1){
		
		printf("\nTrigonometrik degiskenin SÝN ise 1,COS ise 2,TAN ise 3,COT ise 4' bas");
		scanf("%d",&yanit);
		
		if(yanit==1){
			printf("lutfen trigonometrik ifadenin katsayisini giriniz");
			scanf("%d",&trigo_katsayi);
			
			printf("lutfen trigonometrik ifadenin ickatsayisini giriniz\n");
			scanf("%d",&trigo_ickatsayi);
			
			deger[durum]=trigo_katsayi*sin(trigo_ickatsayi);
			
			
		}
		else if(yanit==2){
			printf("lutfen trigonometrik ifadenin katsayisini giriniz");
			scanf("%d",&trigo_katsayi);
			
			printf("lutfen trigonometrik ifadenin ickatsayisini giriniz\n");
			scanf("%d",&trigo_ickatsayi);
			
			deger[durum]=trigo_katsayi*cos(trigo_ickatsayi);
		}
		else if(yanit==3){
			printf("lutfen trigonometrik ifadenin katsayisini giriniz");
			scanf("%d",&trigo_katsayi);
			
			printf("lutfen trigonometrik ifadenin ickatsayisini giriniz\n");
			scanf("%d",&trigo_ickatsayi);
			
			deger[durum]=trigo_katsayi*tan(trigo_ickatsayi);
			
		}
		else if(yanit==4){
			printf("lutfen trigonometrik ifadenin katsayisini giriniz");
			scanf("%d",&trigo_katsayi);
			
			printf("lutfen trigonometrik ifadenin ickatsayisini giriniz\n");
			scanf("%d",&trigo_ickatsayi);
			
			deger[durum]=trigo_katsayi/(tan(trigo_ickatsayi));
			
		}
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
		printf("\ne^x degiskeni var mi?");//cumlede e li bir ifade olup olmadýgýný sor
		printf("\n1) Var.   2) Yok.\n");
		scanf("%d", &cevap);
		if(cevap==1){
			printf("lutfen e^x'in katsayisini giriniz\n");
			scanf("%d",&e_katsayi);
			printf("lutfen e^x'in üst katsayisini giriniz\n");
			scanf("%d",&e_ustkatsayi);
			
			deger[durum]=e_katsayi*pow(E,e_ustkatsayi);
		}
		
		printf("\nNormal X degiskeni var mi?");
		printf("\n1)Var.		2)Yok.");
		scanf("%d",&cevap);
		if(cevap==1){
			printf("lutfen katsayisini giriniz\n");
			scanf("%d",&x_katsayi);
			
			printf("lutfen üssünü giriniz");
			scanf("%d",&x_ustkatsayi);
			
			deger[durum]=x_katsayi*pow(x,x_ustkatsayi);
		}
		printf("%d",durum);
		
		toplam=toplam+deger[durum];
		durum=durum+1;
		
		
		
	}
	return toplam;
}

void RK4(double x0, double y0[], double x, double h, DIF eq,int M) {
  
	int steps = (int)((x - x0) / h);
   
    
    int xson=x0;
    int i;
    double sonuc1,sonuc2;
    double toplam=0;
	
    for (i = 0; i < steps; i++) {
        
        
        
        sonuc2=f(xson, y0, eq);
        sonuc1=denklemHesaplaX(xson,M);
		double k1 = h * (sonuc1+sonuc2);
        
        printf("ikinci kýsma geçildi\n");
        sonuc2=f(xson + 0.5 * h, y0, eq);
        xson=(xson+0.5*h);
        sonuc1=denklemHesaplaX(xson,M);
        double k2 = h * (sonuc1+sonuc2);
        
        printf("ücüncü kisma gecildi\n");
        sonuc2=f(xson + 0.5 * h, y0, eq);
        xson=(xson+0.5*h);
        sonuc1=denklemHesaplaX(xson,M);
		double k3 = h * (sonuc1+sonuc2);
        
        printf("dördüncü kisma gecildi\n");
        sonuc2=f(xson + h, y0, eq);
        xson=(xson+0.5*h);
        sonuc1=denklemHesaplaX(xson,M);
		double k4 = h * (sonuc1+sonuc2);
		
	
		 
        toplam = toplam + (k1 + 2*k2 + 2*k3 + k4) / 6;
        xson += h;

        printf("\nAdim %d: Yaklasik deger = %lf\n", i+1, toplam);
        
    }

    printf("Cozum: x = %lf için y = %lf\n", x0, toplam);
}
double f(double x,double y0[], DIF eq) {
    double result = 0.0;
    int i;
    for (i = 0; i <= eq.mertebe; i++) {
        result += eq.katSayi[i] * y0[i];
    }
    return result;
}





