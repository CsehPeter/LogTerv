`timescale 1ns / 1ps
//`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company:     BME
// Engineer:    Nagy Tímea Csilla(O5D5VN), Cseh Péter(DM5HMB)
// 
// Create Date: 17.04.2017 12:39:55
// Design Name: alu
// Module Name: alu
//////////////////////////////////////////////////////////////////////////////////

module alu
    (
        input clk,
        
        input [2:0] a_addr,
        input [2:0] b_addr,
        input [7:0] const,
        input [2:0] op,
        input cin,
		input zero_in,
        
        output reg [7:0] y,
        output reg cout,
        output reg ovf,
        output reg zero,
        output reg neg
    );
    
//Operation Codes
parameter MOV = 3'b000;
parameter AND = 3'b001;
parameter OR  = 3'b010;
parameter XOR = 3'b011;
parameter RRC = 3'b100;
parameter CMP = 3'b101;
parameter ADD = 3'b110;
parameter SUB = 3'b111;
   
//8x8 Register Array(Block RAM)
reg [7:0] regs[7:0];

//A and B operands
wire [7:0] a = regs[a_addr];
wire [7:0] b = regs[b_addr];
    
//MOV
wire [7:0] y_mov = const;

//AND
wire [7:0] y_and = a & b;

//OR
wire [7:0] y_or = a | b;

//XOR
//At opcode = 1X1(CMP and SUB) -> negates the b operand
wire neg_b = op[0] & op[2];

wire [7:0] in_xor = neg_b == 1'b1 ? {8{1'b1}} : a;

wire [7:0] y_xor = in_xor ^ b; 

//RRC : Rotates "a" to right over carry in
wire [7:0] y_rrc = {a[0], cin, a[7:1]};

//ARITH
//ADD: a + b + cin
//CMP, SUB: a - b - cin = a + (~b + 1'b1) - cin = a + ~b + ~cin

wire [7:0] arith_in = (neg_b == 1'b1) ? y_xor : b;
wire arith_cin = neg_b ^ cin; //negated carry in for CMP and SUB

wire [8:0] y_arith = a + arith_in + arith_cin;

wire ovf_arith = (a[7] & b[7] & ~y_arith[7]) | (~a[7] & ~b[7] & y_arith[7]);

reg [8:0] r_y;
reg r_cout;
reg r_ovf;
reg r_zero;
reg r_neg;

//MUXES
always @ (*)
begin
    //Y
    case (op)
        MOV : r_y <= {1'b0, y_mov};
        AND : r_y <= {1'b0, y_and};
        OR  : r_y <= {1'b0, y_or};
        XOR : r_y <= {1'b0, y_xor};
        RRC : r_y <= y_rrc;
        CMP : r_y <= {y_arith[8], a}; //result not changed
        ADD : r_y <= y_arith;
        SUB : r_y <= {~y_arith[8], y_arith[7:0]};  //~carry 
     endcase
     
     //COUT
     r_cout <= r_y[8];
     
     //OVF
     case (op)
        CMP : r_ovf <= ovf_arith;
        ADD : r_ovf <= ovf_arith;
        SUB : r_ovf <= ovf_arith;
        default: r_ovf <= 1'b0;
     endcase
     
     //ZERO
     case (op)
        MOV : r_zero <= 1'b0;
        default: r_zero <= ~|r_y[7:0];
     endcase
     
     //NEG
     case (op)
         MOV : r_neg <= 1'b0;
         default: r_neg <= r_y[7];
     endcase
     
end

//Write the result back to a_addr
always @ (posedge clk)
    regs[a_addr] <= r_y[7:0];
    
//Output regs
always @ (posedge clk)
begin
    y <= r_y;
    cout <= r_cout;
    ovf <= r_ovf;
    zero <= (r_zero & zero_in);
    neg <= r_neg;
end

endmodule