// Code your testbench here
// or browse Examples

`timescale 1ns / 1ps 
module full_adderV_tb;
 
	parameter SIZE = 5;
	
    wire    cout_tb;
    reg     cin_tb; 
    wire    [SIZE-1:0] sum_tb; 
	
    reg     [SIZE-1:0] a_tb, b_tb; 
  
  defparam myAdder_dut.SIZE = SIZE; 				//overide SIZE in the instantiated module 
  fourBitAdder myAdder_dut (.cout(cout_tb), .sum_o(sum_tb), .ain(a_tb), .bin(b_tb), .cin(cin_tb)); 
    
    initial begin
      $display("		Time  -->   ain, bin, cin, Co, Sum",);
      repeat (8) begin
        #5;
        $display("%d  --->  %4d %4d %2b %3b %4d",$time, $unsigned(a_tb), $unsigned(b_tb), cin_tb, cout_tb, $unsigned(sum_tb));
      end
      	$finish;
    end 

    initial begin 
        a_tb = $random;  
        b_tb = $random; 
        cin_tb = 1'b0;
      
        #5 //2     
        a_tb = $random;  
        b_tb = $random;  
        cin_tb = 1'b1;
        
        #5 //3 
        a_tb = $random;  
        b_tb = $random;  
        cin_tb = 1'b0;
        
        #5 //4 
        a_tb = $random;  
        b_tb = $random; 
        cin_tb = 1'b1;
        
        #5 //5 
        a_tb = $random;  
        b_tb = $random;  
        cin_tb = 1'b0;
        
        #5 //6 
        a_tb = $random;  
        b_tb = $random;  
        cin_tb = 1'b1;
        
        #5 //7 
        a_tb = $random;  
        b_tb = $random;  
        cin_tb = 1'b0;
    
        #5 //8
        a_tb = $random;  
        b_tb = $random;  
        cin_tb = 1'b1;
        
        #10
        $stop;
    end 
endmodule

// Code your design here
//######### 1 Bit Adder ##############################
`timescale 1ns / 1ps 
module fourBitAdder ( cout, sum_o, ain, bin, cin);

//Parameters, Ports / IOs
	parameter SIZE = 4; 
	
    input   [SIZE-1:0] ain, bin; 
    input   cin; 	
    output  [SIZE-1:0] sum_o;
    output  cout; 
	
//Internal signals and Instances..
	wire 	[SIZE-1:0] ci_int;
	wire 	[SIZE-1:0] co_int; 	
	
	oneBit_Adder myMultiBitAddr [SIZE-1:0] (co_int, sum_o, ain, bin, ci_int);		//module instantiation 
	
//#### The Main Code #######	
	assign ci_int[0]		= cin;
	assign ci_int[SIZE-1:1] = co_int[SIZE-2:0];		//ci_int[3:1] = co_int[2:0]
	assign cout				= co_int[SIZE-1]; 		
  
endmodule



// Code your design here
//######### 1 Bit Adder ##############################
`timescale 1ns / 1ps 
module oneBit_Adder (cout, sum_o, ain, bin, cin); 
    input   ain, bin, cin; 
    output  sum_o, cout; 
	
//Behavioural code	
//  assign {cout, sum_o} = ain + bin + cin;

//Sturctural code 
  	wire tmp, outL, outR;
	
  	xor l_xor(tmp, ain, bin);
	xor r_xor(sum_o, cin, tmp);
	and l_and(outL, ain, bin);
	and r_and(outR, tmp, cin);
	or  my_or(cout, outR, outL);
    
endmodule
