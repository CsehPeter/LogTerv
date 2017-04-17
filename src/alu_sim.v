`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:     BME
// Engineer:    Vadmacska(O5D5VN), R0ck$tar(DM5HMB)
// 
// Create Date: 17.04.2017 12:39:55
// Design Name: alu
// Module Name: alu_sim
//////////////////////////////////////////////////////////////////////////////////

module alu_sim;

	// Inputs
	reg clk;
    reg [7:0] a;
    reg [7:0] b;
    reg [2:0] op;
    reg cin;
    
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
        .a(a),
		.b(b), 
		.op(op), 
		.cin(cin), 
		.y(y),
		.cout(cout),
		.ovf(ovf),
		.zero(zero),
		.neg(neg)
	);

initial begin
    clk = 0;
    a = 8'h00;
    b = 8'h00;
    op = 3'b100;
    cin = 1'b0;
end

always #10 clk = ~clk;

reg [7:0] cntra;
reg [7:0] cntrb;
reg [2:0] cntr_op;

always @ (posedge clk)
begin

    //stim input a
    a = a + 8;
    if(a == 128)
    begin
        op = op + 1;
        cin = ~cin;
    end
        
    //stim input b
    b = b + 2;
    
end

endmodule