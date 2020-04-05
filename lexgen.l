%{
#include<glib.h>
GPtrArray* tokens;
GHashTable* noTerm;

void iteratorTokens(void* data, void* not_used){
    printf("FIXME\t{return %s;}\n", (char*) data);
}

void iteratorNoTerm(void* key, void* value, void* not_used){
    printf("%s", (char*) key);
}

void end_parser(){
    g_ptr_array_foreach(tokens, iteratorTokens, NULL);
    if(g_hash_table_size(noTerm) > 0){
        printf("[");
        g_hash_table_foreach(noTerm, iteratorNoTerm, NULL);
        printf("]\t{return yytext[0];}\n");
    }
}

%}
%option stack
%x TOKEN C GRAM COMMENT
%%

^%(?i:token)[ ]*        {yy_push_state(TOKEN);}

<TOKEN>[ ]+             { ; }
<TOKEN>[<].*[>]         { ; }
<TOKEN>[/][/]           {yy_pop_state();}
<TOKEN>[/][*]           {yy_push_state(COMMENT);}
<TOKEN>[A-z]+           {g_ptr_array_add(tokens,strdup(yytext));}
<TOKEN>\n               {yy_pop_state();}

<COMMENT>[*][/]         {yy_pop_state();}
<COMMENT>.|\n           { ; }

^[ ]*%%[ ]*[\r\n]*      {yy_push_state(GRAM);}

<GRAM>'.[nrt0b]*/'              {g_hash_table_insert(noTerm,strdup(yytext + 1),NULL);}
<GRAM>[^'][{][^']       {yy_push_state(C);}
<GRAM>.|\n              { ; }

<C>[{]                  {yy_push_state(C);}
<C>[}]                  {yy_pop_state();}
<C>.|[\r\n]             { ; }

<GRAM>^[ ]*%%           {yy_pop_state();puts("%%");end_parser(); puts("%%");}

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
    
    tokens = g_ptr_array_new();
    noTerm = g_hash_table_new(g_str_hash, g_str_equal);

    yylex();

    return 0;
}
