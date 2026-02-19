/*++
Problema 15:
Se citesc de la tastatura un numar natural n si n propozitii care contin cel putin n cuvinte (nu se fac validari).
Sa se afiseze sirul format prin concatenarea cuvintelor de pe pozitia i din propozitia i, i=1,n (separate prin spatiu).
Exemplu: Se da: n=5
Ana are mere si pere.
Pe birou se gaseste un cos cu fructe.
Cartea mea preferata se afla pe masa.
Afara a nins si este destul de frig.
Maine o sa merg la cumparaturi.
Se va afisa:
Ana birou preferata si la
--*/

#include <stdio.h>
#include <string.h>

void citire_siruri(int n,char s[]);
char *get_word(char sentence[],int poz);
const char asmConcat(char propozitie_finala[],char cuvant[]);
	 
int main(){
		
	printf("Scrie numarul de propozitii: ");
	int n;
	scanf("%d", &n);
	getchar();  
	
	char sir_final[500]="";
	printf("Scrie %d propozitii: \n",n);
	citire_siruri(n,sir_final);
	
	printf("Propozitia finala este: %s\n",sir_final);
	return 0;
	
}

void citire_siruri(int n,char sir_final[])
{
	char s[50];

	for(int i=1;i<=n;i++){
		fgets(s, sizeof(s), stdin);  // Read a full line (sentence)
        s[strcspn(s, "\n")] = '\0'; 
 		
		char* cuvant = get_word(s,i);
		
		if(cuvant){
		asmConcat(sir_final,cuvant);
		strcat(sir_final," ");
		}
	}
	
}

char *get_word(char sentence[],int poz)
{
	int cnt=1;
	char* cuvant=strtok(sentence," ");
	
	while(cuvant!=NULL){
		if(cnt==poz){
			return cuvant;
		}
		cnt++;
		cuvant=strtok(NULL," ");
	}
}
