void s(int a[]);
int main ()
{
int k,Y;
int Z[50];
   Y=56;
for(k=0;k<50;k++) {
    Z[k]=Y-16*(k/4+210);
}
s(Z);
return 0;
}