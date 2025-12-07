module maindec (
    input  wire [5:0] opcode,
    output wire       we_reg,
    output wire       alu_src,
    output wire       branch,
    output wire       we_dm,
    output wire [1:0] alu_op,
    output wire       jump,
    output wire [1:0] reg_dst,  // 25:21 || 20:16 || $ra
    output wire [1:0] dm2reg    // rf_wd_src || dm || $ra
);
  reg [10:0] ctrl;

  assign {we_reg, reg_dst, alu_src, branch, we_dm, dm2reg, alu_op, jump} = ctrl;

  always @(opcode) begin
    case (opcode)
      6'b00_0000: ctrl = 11'b1_01_0_0_0_00_10_0;  // R-type
      6'b10_0011: ctrl = 11'b1_00_1_0_0_01_00_0;  // LW
      6'b10_1011: ctrl = 11'b0_00_1_0_1_00_00_0;  // SW
      6'b00_0100: ctrl = 11'b0_00_0_1_0_00_01_0;  // BEQ
      6'b00_1000: ctrl = 11'b1_00_1_0_0_00_00_0;  // ADDI
      6'b00_0010: ctrl = 11'b0_00_0_0_0_00_00_1;  // J
      6'b00_0011: ctrl = 11'b1_10_0_0_0_10_00_1;  // JAL
      default: ctrl = 11'bx_x_xx_x_x_x_xx_xx;
    endcase
  end
endmodule
