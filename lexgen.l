%{
int count = 0;
%}
%option stack
%x TOKEN C GRAM 
%%

^%(?i:token)[ ]*        {yy_push_state(TOKEN);printf("%%%%\n");}
<TOKEN>[ ]+             { ; }
<TOKEN>[A-z]+           {printf("FIXME\t{return %s;}\n", yytext);}
<TOKEN>\n               {yy_pop_state();}

^[ ]*%%[ ]*[\r\n]*      {yy_push_state(GRAM);}

<GRAM>'./'              {if(count == 0) {printf("[");};printf("%s", yytext + 1);count++;}
<GRAM>[^'][{][^']       {yy_push_state(C);}
<GRAM>.|\n              { ; }

<C>[{]                  {yy_push_state(C);}
<C>[}]                  {yy_pop_state();}
<C>.|[\r\n]             { ; }

<GRAM>^[ ]*%%           {yy_pop_state();if(count > 0) {printf("]\t{return yytext[0];}\n");} printf("%%%%\n");}

.|\n                    { ; }

%%
int yywrap()
{ return(1); }

int main(int argc, char* argv[])
{
    if(argc > 1)
    {
        FILE *fp = fopen(argv[1], "r");
        if(fp)
            yyin = fp;
    }
    
    yylex();

    return 0;
}
