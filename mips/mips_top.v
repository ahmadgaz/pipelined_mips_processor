module mips_top (
    input wire        clk,
    input wire        rst,
    input wire [ 4:0] ra3,
    input wire [31:0] rd_dmi,
    input wire        we_dmi,

    output wire [31:0] rd3,
    output wire [31:0] pc_current,
    output wire [31:0] instr,
    output wire [31:0] alu_out,
    output wire [31:0] wd_dm,
    output wire        we_dmo,
    output wire [31:0] rd_dmo
);

  wire [31:0] DONT_USE;

  mips mips (
      .clk       (clk),
      .rst       (rst),
      .ra3       (ra3),
      .pc_current(pc_current),
      .instr     (instr),
      .alu_out   (alu_out),
      .wd_dm     (wd_dm),
      .we_dm     (we_dmo),
      .rd_dm     (rd_dmi),
      .rd3       (rd3)
  );

  imem imem (
      .a(pc_current[7:2]),
      .y(instr)
  );

  dmem dmem (
      .clk(clk),
      .rst(rst),
      .we (we_dmi),
      .a  (alu_out[7:2]),
      .d  (wd_dm),
      .q  (rd_dmo)
  );

endmodule

