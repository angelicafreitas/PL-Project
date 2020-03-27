%token ID MKLISTA NULA
%%
    lista : MKLISTA '(' ids ')'     {... ação semântica em C }
        | NULA
        ;  
    ids : ID ',' ids    { ignorar as constantes char (ex: '!') das ações semânticas }
        | ID    { if ( 'a' == 'a') { printf("Ok") } else { printf("Ok")} }
        ;
%%

int main(){
    yylex();
    return 0;
}