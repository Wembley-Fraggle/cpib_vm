grammar InputArgs;

options 
{
    language = Java;
}

@parser::members {
    int codeSize = 1000;
    int storeSize = 1000;
    
    public int getStoreSize() {
        return this.storeSize;
    }
    
    public int getCodeSize() {
        return codeSize;
    }
}


program:
    (codeSizeDecl | storeSizeDecl)*
;
codeSizeDecl :
    CODE_SIZE intVal
    {
        codeSize = $intVal.val;
    }
;

storeSizeDecl :
    STORE_SIZE intVal
    {
        storeSize = $intVal.val;
    }
;

intVal returns [int val]: INTEGER
{
    try {
        $val = Integer.parseInt($INTEGER.text);
    }
    catch(NumberFormatException ex) {
         notifyErrorListeners("Invalid number format. Expected an integer");
    }
}
;


INTEGER: [0-9]+;
CODE_SIZE:   '--codeSize';
STORE_SIZE:  '--storeSize';
WS: [\t\r\n ]+ -> skip ; 