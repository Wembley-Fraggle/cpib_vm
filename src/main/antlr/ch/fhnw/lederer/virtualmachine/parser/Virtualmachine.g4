grammar Virtualmachine;

options 
{
    language = Java;
}

@header {

import ch.fhnw.lederer.virtualmachine.IVirtualMachine;
}

@parser::members {
    IVirtualMachine vm;
    
    public VirtualmachineParser(TokenStream input,IVirtualMachine vm){
        this(input);
        this.vm = vm;
    }
}
program: commands*;

commands:
         stopCmd | allocCmd | callCmd | returnCmd | copyInCmd | copyOutCmd 
       | enterCmd | intLoadCmd | floatLoadCmd | loadRelCmd | derefCmd 
       | storeCmd | intInvCmd | floatInvCmd | intAddCmd | intSubCmd 
       | intMultCmd | intDivCmd | intModCmd  | intEqCmd | intNeCmd | intGtCmd
       | intLtCmd | intGeCmd | intLeCmd | uncondJumpCmd |condJumpCmd
       | boolInputCmd |intInputCmd | boolOutputCmd | intOutputCmd;

stopCmd : STOP loc=intVal
{
    try {
        vm.Stop($loc.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
};

allocCmd : ALLOC loc=intVal COMMA size=intVal 
{
    try {
        vm.Alloc($loc.val,$size.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
};

callCmd : CALL loc=intVal COMMA address=intVal {
    try{
        vm.Call($loc.val, $address.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}
;

returnCmd : RETURN loc=intVal COMMA size=intVal
{   try{
        vm.Return($loc.val, $size.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
};

copyInCmd throws IVirtualMachine.CodeTooSmallError:
COPY_IN loc=intVal COMMA from=intVal COMMA to=intVal {
    try {
        vm.CopyIn($loc.val,$from.val,$to.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
};


copyOutCmd: COPY_OUT loc=intVal COMMA from=intVal COMMA to=intVal
{
    try {
        vm.CopyOut($loc.val,$from.val,$to.val);
    }
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }        
}
;

enterCmd: ENTER loc=intVal COMMA size=intVal COMMA extreme=intVal
{
    try {
        vm.Enter($loc.val, $size.val, $extreme.val);
    }
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    } 
};

intLoadCmd : INT_LOAD loc=intVal COMMA value=intVal
{
    try {
        vm.IntLoad($loc.val, $value.val);
    }
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
};

floatLoadCmd: FLOAT_LOAD loc=intVal COMMA value=floatVal {
    try{
        vm.FloatLoad($loc.val,$value.val);
    }
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
};

loadRelCmd: LOAD_REL loc=intVal COMMA address=intVal {
    try{
        vm.LoadRel($loc.val,$address.val);
    }
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
};

derefCmd: DEREF loc=intVal {
    try{
        vm.Deref($loc.val);
    }
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
};

storeCmd: STORE loc=intVal {
    try {
        vm.Store($loc.val);
    }
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
};

intInvCmd: INT_INV loc=intVal {
    try {
        vm.IntInv($loc.val);
    }
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
};

floatInvCmd: FLOAT_INV loc=intVal {
    try {
        vm.FloatInv($loc.val);
    }
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
};

intAddCmd : INT_ADD loc=intVal {
    try {
        vm.IntAdd($loc.val);
    }
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
};  

intSubCmd : INT_SUB loc=intVal {
    try {
        vm.IntSub($loc.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

intMultCmd : INT_MULT loc=intVal {
    try {
        vm.IntMult($loc.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

intDivCmd : INT_DIV  loc=intVal {
    try {
        vm.IntDiv($loc.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

intModCmd : INT_MOD  loc=intVal {
    try {
        vm.IntMod($loc.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

intEqCmd : INT_EQ loc=intVal {
    try {
        vm.IntEQ($loc.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

intNeCmd : INT_NE loc=intVal {
    try {
        vm.IntNE($loc.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

intGtCmd : INT_GT loc=intVal {
    try {
        vm.IntGT($loc.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

intLtCmd : INT_LT loc=intVal {
    try {
        vm.IntLT($loc.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

intGeCmd : INT_GE loc=intVal {
    try {
        vm.IntGE($loc.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

intLeCmd : INT_LE loc=intVal {
    try {
        vm.IntLE($loc.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

uncondJumpCmd : UNCOND_JUMP loc=intVal COMMA jumpLoc=intVal {
    try {
        vm.UncondJump($loc.val,$jumpLoc.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

condJumpCmd : COND_JUMP loc=intVal COMMA jumpLoc=intVal {
    try {
        vm.CondJump($loc.val, $jumpLoc.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

boolInputCmd : BOOL_INPUT loc=intVal COMMA indicator=stringVal {
    try {
        vm.BoolInput($loc.val, $indicator.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

boolOutputCmd : BOOL_OUTPUT loc=intVal COMMA indicator=stringVal {
    try {
        vm.BoolOutput($loc.val, $indicator.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

intInputCmd : INT_INPUT loc=intVal COMMA indicator=stringVal {
    try {
        vm.IntInput($loc.val, $indicator.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

intOutputCmd : INT_OUTPUT loc=intVal COMMA indicator=stringVal {
    try {
        vm.IntOutput($loc.val, $indicator.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 


intVal returns [int val]: INT
{
    try {
        $val = Integer.parseInt($INT.text);
    }   
    catch(NumberFormatException ex) {
       notifyErrorListeners("Invalid number format. int expected");
    }
};

floatVal returns [float val]: FLOAT {
    try {
        $val = Float.parseFloat($FLOAT.text);
    }   
    catch(NumberFormatException ex) {
       notifyErrorListeners("Invalid number format. Float expected");
    }
};

stringVal returns [String val]: STRING {
    String s = $STRING.text;
    s = s.substring(1, s.length() - 1);
    $val = s;
};

STOP         : 'Stop';
ALLOC        : 'Alloc';
CALL         : 'Call';
RETURN       : 'Return';
COPY_IN      : 'CopyIn';
COPY_OUT     : 'CopyOut';
ENTER        : 'Enter';
INT_LOAD     : 'IntLoad';
FLOAT_LOAD   : 'FloatLoad';
LOAD_REL     : 'LoadRel';
DEREF        : 'Deref';
STORE        : 'Store';
INT_INV      : 'IntInv';
FLOAT_INV    : 'FloatInv';
INT_ADD      : 'IntAdd';
INT_SUB      : 'IntSub';      
INT_MULT     : 'IntMult';     
INT_DIV      : 'IntDiv';      
INT_MOD      : 'IntMod';      
INT_EQ       : 'IntEQ';       
INT_NE       : 'IntNE';       
INT_GT       : 'IntGT';       
INT_LT       : 'IntLT';       
INT_GE       : 'IntGE';       
INT_LE       : 'IntLE';       
UNCOND_JUMP  : 'UncondJump';  
COND_JUMP    : 'CondJump';    
BOOL_INPUT   : 'BoolInput';   
BOOL_OUTPUT : 'BoolOutput';
INT_INPUT   : 'IntInput';    
INT_OUTPUT  : 'IntOutput';
COMMA       : ',';

FLOAT:      '-'? [0-9]+ '.' [0-9]*;
INT:        '-'?[0-9]+;
STRING      : '"' .*? '"';

WS: [\t\r\n ]+ -> skip ; 