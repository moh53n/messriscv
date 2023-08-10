module ALU (
    input clk,
    input [2:0] funct3,
    input [31:0] i1,
    input [31:0] i2,
    input funct7_5,
    output reg [31:0] alu_out
);
    always @(posedge clk) begin
        case (funct3) 
            3'b000: begin  // ADDI / ADD - SUBI / SUB
                alu_out <= funct7_5 ? (i1 - i2) : (i1 + i2);
            end
            3'b001: begin  // SLLI / SLL
                alu_out <= i1 << i2[4:0];
            end
            3'b010: begin  // SLTI / SLT
                alu_out <= {31'b0, $signed(i1) < $signed(i2)};
            end
            3'b011: begin  // SLTIU / SLTU
                alu_out <= {31'b0, i1 < i2};
            end
            3'b100: begin  // XORI / XOR
                alu_out <= i1 ^ i2;
            end
            3'b101: begin  // SRLI / SRL - SRAI / SRA
                alu_out <= funct7_5 ? (i1 >>> i2[4:0]) : (i1 >> i2[4:0]);
            end
            3'b110: begin  // ORI / OR
                alu_out <= i1 | i2;
            end
            3'b111: begin  // ANDI / AND
                alu_out <= i1 & i2;
            end
        endcase
    end
endmodule
