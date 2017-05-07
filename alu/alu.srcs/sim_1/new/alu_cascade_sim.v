`timescale 1ns / 1ps
//`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company:     BME
// Engineer:    Nagy Tímea Csilla(O5D5VN), Cseh Péter(DM5HMB)
// 
// Create Date: 17.04.2017 12:39:55
// Design Name: alu
// Module Name: alu_sim
//////////////////////////////////////////////////////////////////////////////////


module alu_cascade_sim;

	// Inputs
	reg clk;
	reg [2:0] a_addr[1:0];
	reg [2:0] b_addr[1:0];
	reg [7:0] const[1:0];
    reg [2:0] op;
    reg cin;
    reg zero_in;
    
    //Outputs
    wire [7:0] y[1:0];
    wire cout[1:0];
    wire ovf[1:0];
    wire zero[1:0];
    wire neg[1:0];

	// Instantiate the Unit Under Test (UUT)
	//ALU1
	alu uut1
	(
		.clk(clk),
		.a_addr(a_addr[0]),
		.b_addr(b_addr[0]),
		.const(const[0]), 
		.op(op), 
		.cin(cin),
		.zero_in(zero_in),
		 
		.y(y[0]),
		.cout(cout[0]),
		.ovf(ovf[0]),
		.zero(zero[0]),
		.neg(neg[0])
	);
	
	//ALU2
	alu uut2
        (
            .clk(clk),
            .a_addr(a_addr[1]),
            .b_addr(b_addr[1]),
            .const(const[1]), 
            .op(op), 
            .cin(cout[0]),
            .zero_in(zero[0]),
             
            .y(y[1]),
            .cout(cout[1]),
            .ovf(ovf[1]),
            .zero(zero[1]),
            .neg(neg[1])
        );
        
wire [15:0] result = {y[1], y[0]};
        
//Operation Codes
parameter MOV = 3'b000;
parameter AND = 3'b001;
parameter OR  = 3'b010;
parameter XOR = 3'b011;
parameter RRC = 3'b100;
parameter CMP = 3'b101;
parameter ADD = 3'b110;
parameter SUB = 3'b111;

reg[1:0] i;
initial begin
    clk = 0;
    cin <= 0;
    zero_in <= 0;
    op <= MOV;
    for(i = 0; i < 2; i = i + 1)
    begin
        a_addr[i] <= 0; 
        b_addr[i] <= 1;
        const[i] <= 0;
    end
end



always #10 clk = ~clk;

initial #20 a_addr[0] = 1;
initial #40 const[0] = 20;
initial #60 a_addr[0] = 0; 
initial #80 const[0] = 30;

initial #120 a_addr[1] = 1;
initial #140 const[1] = 40;
initial #160 a_addr[1] = 0; 
initial #180 const[1] = 50;

initial #200 op <= ADD;

initial #400 op <= SUB;

endmodule
