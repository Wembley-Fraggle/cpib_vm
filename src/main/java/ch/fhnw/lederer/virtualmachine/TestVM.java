package ch.fhnw.lederer.virtualmachine;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;

import ch.fhnw.lederer.virtualmachine.IVirtualMachine.ExecutionError;
import ch.fhnw.lederer.virtualmachine.inputargs.InputArgsLexer;
import ch.fhnw.lederer.virtualmachine.inputargs.InputArgsParser;
import ch.fhnw.lederer.virtualmachine.parser.VirtualmachineLexer;
import ch.fhnw.lederer.virtualmachine.parser.VirtualmachineParser;

/* Dr. Edgar Lederer, Fachhochschule Nordwestschweiz */

public class TestVM {

    public static void main(String[] args) {
        if(args.length < 1) {
            System.out.println("Invalid number or arguments");
            showUsageAndExit();
        }
        InputArgsParser inputParser = parseArguments(args);
        int codeSize = inputParser.getCodeSize();
        int storeSize = inputParser.getStoreSize();
        
        String filePath = args[args.length-1];
        
        try(InputStream fs = TestVM.class.getClassLoader().getResourceAsStream(filePath))
        {
            VirtualMachine vm = new VirtualMachine(codeSize, storeSize);
            
            InputStreamReader reader = new InputStreamReader(fs,"UTF-8");
            ANTLRInputStream lexerStream = new ANTLRInputStream(reader);
            VirtualmachineLexer lexer = new VirtualmachineLexer(lexerStream);
            CommonTokenStream tokenStream = new CommonTokenStream(lexer);
            VirtualmachineParser parser = new VirtualmachineParser(tokenStream,vm);
            
            parser.program();
            if(parser.getNumberOfSyntaxErrors() > 0) {
                System.exit(-1);
            }
            
            vm.execute();
        } catch (IOException | ExecutionError e) {
           System.err.println(e.toString());
        }
    }
    
    private static void showUsageAndExit() {
        System.out.println("Usage: TestVM [--codeSize <size>] [--storeSize <size>] filepath");
        System.exit(0);
    }

    private static InputArgsParser parseArguments(String[] args) {
        StringBuilder inArgsBuffer = new StringBuilder();
        for(int i = 0; i < args.length-1; i++) {
            inArgsBuffer.append(args[i]).append(" ");
        }
        ANTLRInputStream inArgsStream = new ANTLRInputStream(inArgsBuffer.toString());
        InputArgsLexer lexer = new InputArgsLexer(inArgsStream);
        CommonTokenStream inArgsTokenStream = new CommonTokenStream(lexer);
        InputArgsParser inputParser = new InputArgsParser(inArgsTokenStream);
        inputParser.program();
        if(inputParser.getNumberOfSyntaxErrors() > 0) {
            System.out.println("Invalid arguments");
            showUsageAndExit();
        }
        
        return inputParser;
    }
}
