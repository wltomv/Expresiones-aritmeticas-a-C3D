
%{
    let contador=0;
    function nuevoTemporal(){
        var temporal="t"+ contador;
        contador++;
        return temporal;
    }
%}


/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */

([a-zA-Z])[a-zA-Z0-9_]*	  return 'ID';
[0-9]+("."[0-9]+)?\b  return 'NUMERO'

"*"                   return '*'
"/"                   return '/'
"-"                   return '-'
"+"                   return '+'
"^"                   return '^'
"("                   return '('
")"                   return ')'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%left '+' '-'
%left '*' '/'
%left '^'
%left UMINUS

%start expressions

%% /* language grammar */

expressions
    : E EOF
        
        {contador=0;return $1;}
    ;

E
    : E '+' T { var temporal=nuevoTemporal()
                $$ = {
                        TMP:temporal,
                        C3D: `${$1.C3D}${$3.C3D}${temporal} = ${$1.TMP} + ${$3.TMP} \n`
                     }
    } 
        
    | E '-' T{ var temporal=nuevoTemporal()
                $$ = {
                        TMP:temporal,
                        C3D: `${$1.C3D}${$3.C3D}${temporal} = ${$1.TMP} - ${$3.TMP} \n`
                     }
    } 
        
    | T {$$ = {
                TMP:$1.TMP,
                C3D: $1.C3D
               }
    } 
;

T
    : T '*' F  { var temporal=nuevoTemporal()
                $$ = {
                        TMP:temporal,
                        C3D: `${$1.C3D}${$3.C3D}${temporal} = ${$1.TMP} * ${$3.TMP} \n`
                     }
    } 
        
    | T '/' F { var temporal=nuevoTemporal()
                $$ = {
                        TMP:temporal,
                        C3D: `${$1.C3D}${$3.C3D}${temporal} = ${$1.TMP} / ${$3.TMP} \n`
                     }
    }   
    | F { $$ = {
                TMP:$1.TMP,
                C3D:$1.C3D
        }
    }    
;

F
    : '(' E ')' 
        {$$ = {
                TMP:`${$2.TMP}`,
                C3D: `${$2.C3D}`
            }
        }
    | ID   
        {
            $$={
                TMP: `${$1}`,
                C3D: ``
            }

        }
    | NUMERO{
            $$={
                TMP: `${$1}`,
                C3D: ``
            }

        }
;

