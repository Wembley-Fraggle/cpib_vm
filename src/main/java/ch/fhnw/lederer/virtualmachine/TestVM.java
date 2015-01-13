package ch.fhnw.lederer.virtualmachine;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;

import ch.fhnw.lederer.virtualmachine.IVirtualMachine.ExecutionError;
import ch.fhnw.lederer.virtualmachine.parser.VirtualmachineLexer;
import ch.fhnw.lederer.virtualmachine.parser.VirtualmachineParser;

/* Dr. Edgar Lederer, Fachhochschule Nordwestschweiz */

public class TestVM {

    public static void main(String[] args) {
        String filename = System.getProperty("file");
        if(filename == null) {
            throw new IllegalArgumentException("Missing file property");
        }
        
        int codeSize  = parseInt(System.getProperty("codeSize"),1000);
        int storeSize = parseInt(System.getProperty("storeSize"),1000);
        
        try(InputStream fs = TestVM.class.getClassLoader().getResourceAsStream(filename))
        {
            if(fs == null) {
               throw new FileNotFoundException();
            }
            VirtualMachine vm = new VirtualMachine(codeSize, storeSize);
            
            InputStreamReader reader = new InputStreamReader(fs,"UTF-8");
            ANTLRInputStream lexerStream = new ANTLRInputStream(reader);
            VirtualmachineLexer lexer = new VirtualmachineLexer(lexerStream);
            CommonTokenStream tokenStream = new CommonTokenStream(lexer);
            VirtualmachineParser parser = new VirtualmachineParser(tokenStream,vm);
            
            parser.program();
            reader.close();
            if(parser.getNumberOfSyntaxErrors() > 0) {
                throw new IllegalArgumentException("Parser erros");
            }
            
            vm.execute();
        } catch (IOException | ExecutionError e) {
           System.err.println(e.toString());
        }
    }
    
    private static int parseInt(String value, int defaultVal) {
        if(value != null) {
            try {
                return Integer.parseInt(value);
            }
            catch(NumberFormatException ex) {
                System.out.println(value + "is not a valid number");
                System.exit(-1);
            }
        }
        return defaultVal;
    }
}
