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


module alu_ops_sim;

	// Inputs
	reg clk;
	reg [2:0] a_addr;
	reg [2:0] b_addr;
	reg [7:0] const;
    reg [2:0] op;
    reg cin;
    reg zero_in;
    
    //Outputs
    wire [7:0] y;
    wire cout;
    wire ovf;
    wire zero;
    wire neg;

	// Instantiate the Unit Under Test (UUT)
	alu uut
	(
		.clk(clk),
		.a_addr(a_addr),
		.b_addr(b_addr),
		.const(const), 
		.op(op), 
		.cin(cin),
		.zero_in(zero_in),
		 
		.y(y),
		.cout(cout),
		.ovf(ovf),
		.zero(zero),
		.neg(neg)
	);

initial begin
    clk = 0;
    a_addr <= 0;
    b_addr <= 1;
    const = 0;
    op = MOV;
    cin = 1'b0;
    zero_in = 1'b1;
end

//Operation Codes
parameter MOV = 3'b000;
parameter AND = 3'b001;
parameter OR  = 3'b010;
parameter XOR = 3'b011;
parameter RRC = 3'b100;
parameter CMP = 3'b101;
parameter ADD = 3'b110;
parameter SUB = 3'b111;

always #10 clk = ~clk;

//Init: clear all reg, write 1 to addr 0; a_addr = 0, b_addr = 1
initial #20 a_addr = 0;
initial #40 a_addr = 1;
initial #60 a_addr = 2;
initial #80 a_addr = 3;
initial #100 a_addr = 4;
initial #120 a_addr = 5;
initial #140 a_addr = 6;
initial #160 a_addr = 7;

//Load test values
initial #180 a_addr = 1;
initial #180 const = 8'h2E;
initial #200 const = 8'hAA;
initial #200 a_addr = 0;
initial #210 op = AND;

initial #220 a_addr = 1;
initial #220 const = 8'h2E;
initial #240 const = 8'hAA;
initial #240 a_addr = 0;
initial #250 op = OR;

initial #260 a_addr = 1;
initial #260 const = 8'h2E;
initial #280 const = 8'hAA;
initial #280 a_addr = 0;
initial #290 op = XOR;

initial #300 a_addr = 1;
initial #300 const = 8'h2E;
initial #320 const = 8'hAA;
initial #320 a_addr = 0;
initial #330 op = RRC;

initial #340 a_addr = 1;
initial #340 const = 8'h2E;
initial #360 const = 8'hAA;
initial #360 a_addr = 0;
initial #370 op = CMP;

initial #380 a_addr = 1;
initial #380 const = 8'h2E;
initial #400 const = 8'hAA;
initial #400 a_addr = 0;
initial #410 op = ADD;

initial #420 a_addr = 1;
initial #420 const = 8'h2E;
initial #440 const = 8'hAA;
initial #440 a_addr = 0;
initial #450 op = SUB;

endmodule
