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
program : instruction*;
       
instruction : loc=intVal COLON cmd[$loc.val];


cmd[int loc]:
         stopCmd[$loc] | errorCmd[$loc]
       | allocCmd[$loc] | callCmd[$loc] 
       | returnCmd[$loc] 
       | copyInCmd[$loc] | copyOutCmd[$loc]
       | enterCmd[$loc]
       | intLoadCmd[$loc] | floatLoadCmd[$loc] 
       | loadRelCmd[$loc] | derefCmd[$loc] | storeCmd[$loc] 
       | intInvCmd[$loc] | floatInvCmd[$loc] 
       | intAddCmd[$loc] | intSubCmd[$loc] | intMultCmd[$loc]
       | intDivCmd[$loc] | intModCmd[$loc]  
       | intEqCmd[$loc] | intNeCmd[$loc] | intGtCmd[$loc]
       | intLtCmd[$loc] | intGeCmd[$loc] | intLeCmd[$loc] 
       | uncondJumpCmd[$loc] | condJumpCmd[$loc]
       | boolInputCmd[$loc] | intInputCmd[$loc] | boolOutputCmd[$loc] 
       | intOutputCmd[$loc]
;

stopCmd[int loc] : STOP
{
    try {
        vm.Stop($loc);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
};

errorCmd[int loc] : ERROR LPARENT indicator=stringVal RPARENT 
{
    try {
        vm.Error($loc, $indicator.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
};

allocCmd[int loc] : ALLOC LPARENT size=intVal RPARENT 
{
    try {
        vm.Alloc($loc,$size.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
};

callCmd[int loc] : CALL LPARENT address=intVal RPARENT {
    try{
        vm.Call($loc, $address.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}
;

returnCmd[int loc] : RETURN LPARENT size=intVal RPARENT 
{   try{
        vm.Return($loc, $size.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
};

copyInCmd[int loc] :
COPY_IN LPARENT from=intVal COMMA to=intVal RPARENT {
    try {
        vm.CopyIn($loc,$from.val,$to.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
};


copyOutCmd[int loc] : COPY_OUT LPARENT from=intVal COMMA to=intVal RPARENT {
    try {
        vm.CopyOut($loc,$from.val,$to.val);
    }
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }        
}
;

enterCmd[int loc] : ENTER LPARENT size=intVal COMMA extreme=intVal RPARENT
{
    try {
        vm.Enter($loc, $size.val, $extreme.val);
    }
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    } 
};

intLoadCmd[int loc] : INT_LOAD LPARENT value=intVal RPARENT
{
    try {
        vm.IntLoad($loc, $value.val);
    }
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
};

floatLoadCmd[int loc] : FLOAT_LOAD LPARENT value=floatVal RPARENT {
    try{
        vm.FloatLoad($loc,$value.val);
    }
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
};

loadRelCmd[int loc] : LOAD_REL LPARENT address=intVal RPARENT{
    try{
        vm.LoadRel($loc,$address.val);
    }
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
};

derefCmd[int loc] : DEREF {
    try{
        vm.Deref($loc);
    }
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
};

storeCmd[int loc] : STORE {
    try {
        vm.Store($loc);
    }
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
};

intInvCmd[int loc] : INT_INV {
    try {
        vm.IntInv($loc);
    }
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
};

floatInvCmd[int loc] : FLOAT_INV  {
    try {
        vm.FloatInv($loc);
    }
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
};

intAddCmd[int loc] : INT_ADD  {
    try {
        vm.IntAdd($loc);
    }
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
};  

intSubCmd[int loc] : INT_SUB  {
    try {
        vm.IntSub($loc);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

intMultCmd[int loc] : INT_MULT  {
    try {
        vm.IntMult($loc);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

intDivCmd[int loc] : INT_DIV   {
    try {
        vm.IntDiv($loc);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

intModCmd[int loc] : INT_MOD   {
    try {
        vm.IntMod($loc);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

intEqCmd[int loc] : INT_EQ  {
    try {
        vm.IntEQ($loc);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

intNeCmd[int loc] : INT_NE  {
    try {
        vm.IntNE($loc);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

intGtCmd[int loc] : INT_GT  {
    try {
        vm.IntGT($loc);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

intLtCmd[int loc] : INT_LT  {
    try {
        vm.IntLT($loc);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

intGeCmd[int loc] : INT_GE  {
    try {
        vm.IntGE($loc);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

intLeCmd[int loc] : INT_LE  {
    try {
        vm.IntLE($loc);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

uncondJumpCmd[int loc] : UNCOND_JUMP LPARENT jumpLoc=intVal RPARENT {
    try {
        vm.UncondJump($loc,$jumpLoc.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

condJumpCmd[int loc] : COND_JUMP LPARENT jumpLoc=intVal RPARENT {
    try {
        vm.CondJump($loc, $jumpLoc.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

boolInputCmd[int loc] : BOOL_INPUT LPARENT indicator=stringVal RPARENT{
    try {
        vm.BoolInput($loc, $indicator.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

boolOutputCmd[int loc] : BOOL_OUTPUT LPARENT indicator=stringVal RPARENT{
    try {
        vm.BoolOutput($loc, $indicator.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

intInputCmd[int loc] : INT_INPUT LPARENT indicator=stringVal RPARENT{
    try {
        vm.IntInput($loc, $indicator.val);
    }   
    catch(IVirtualMachine.CodeTooSmallError ex) {
       notifyErrorListeners("Code too small");
    }
}; 

intOutputCmd[int loc] : INT_OUTPUT LPARENT indicator=stringVal RPARENT{
    try {
        vm.IntOutput($loc, $indicator.val);
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
ERROR        : 'Error';
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
COLON        : ':';
LPARENT      : '(';
RPARENT      : ')';
COMMA        : ',';


FLOAT:      '-'? [0-9]+ '.' [0-9]*;
INT:        '-'?[0-9]+;
STRING      : '"' .*? '"';

WS: [\t\r\n ]+ -> skip ; 