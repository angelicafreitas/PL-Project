%{
/* Declaracoes C diversas */
%}

%option stack
%x C GRAM 
%%

^[ ]*%%[ ]*[\r\n]*  {yy_push_state(GRAM);}

<GRAM>[^'][{][^']   {yy_push_state(C);}

<C>[{]              {yy_push_state(C);}
<C>[}]              {yy_pop_state();}
<C>.|[\r\n]         { ; }

<GRAM>^[ ]*%%       {yy_pop_state();}

.|\n                { ; }

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
