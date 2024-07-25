#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int main(){
    int i,j,dongu,counter=0,N,M;
    while(dongu!=3){
        printf("menu");
        printf("(1)Seyrek matristen sikisik matrise");
        printf("(2)Sikisik matristen seyrek matrise");
        scanf("%d",&dongu);

        if(dongu==1){
            printf("lutfen matrisin boyutlarini giriniz\n");
            scanf("%d %d",&N,&M);

            int matrisA[N][M];
            for(i=0;i<N;i++){
                for(j=0;j<M;j++){
                    scanf("%d",&matrisA[i][j]);
                }

            }
            for(i=0;i<N;i++){
                for(j=0;j<M;j++){
                    if(matrisA[i][j]!=0){
                        counter++;
                    }
                }
                int matrisB[counter][3];
                k=0;
                for(i=0;i<counter;i++){
                    for(j=0;j<3;j++){
                        if(matrisA[i][j]!=0){
                            matrisB[k][0]=i;
                            matrisB[k][1]=j;
                            matrisB[k][2]=matrisA[i][j];
                            k++;
                        }
                    }
                }
                printf("\nSeyrek matris");
                for(i=0;i<N;i++){
                    for(j=0;j<M;j++){
                        printf("%d",)
                    }
                }


            }


        }
    }
}