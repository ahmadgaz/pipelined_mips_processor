module system (
    input wire        clk,
    input wire        rst,
    input wire [ 4:0] ra3,
    input wire [31:0] gpi1,
    input wire [31:0] gpi2,

    output wire [31:0] rd3,
    output wire [31:0] pc_current,
    output wire [31:0] instr,
    output wire [31:0] rd_dm,
    output wire        we_dm,
    output wire [31:0] wd_dm,
    output wire [31:0] alu_out,
    output wire [31:0] gpo1,
    output wire [31:0] gpo2
);
  wire we2;
  wire we1;
  wire wem;
  wire [1:0] rdsel;
  wire [31:0] rd_fact;
  wire [31:0] rd_gpio;
  wire [31:0] rd;

  mips_top mips (
      .ra3(ra3),
      .rd_dmi(rd),
      .we_dmi(wem),
      .rst(rst),
      .clk(clk),
      .rd3(rd3),
      .pc_current(pc_current),
      .instr(instr),
      .alu_out(alu_out),
      .wd_dm(wd_dm),
      .we_dmo(we_dm),
      .rd_dmo(rd_dm)
  );
  mips_ad mips_ad (
      .a(alu_out),
      .we(we_dm),
      .we2(we2),
      .we1(we1),
      .wem(wem),
      .rdsel(rdsel)
  );
  fact_top fact (
      .a  (alu_out[3:2]),
      .we (we1),
      .wd (wd_dm[3:0]),
      .rst(rst),
      .clk(clk),
      .rd (rd_fact)
  );
  gpio_top gpio (
      .a(alu_out[3:2]),
      .we(we2),
      .wd(wd_dm),
      .gpi1(gpi1),
      .gpi2(gpi2),
      .rst(rst),
      .clk(clk),
      .rd(rd_gpio),
      .gpo1(gpo1),
      .gpo2(gpo2)
  );
  mux4 #(32) rd_mux (
      .a  (rd_dm),
      .b  (rd_dm),
      .c  (rd_fact),
      .d  (rd_gpio),
      .sel(rdsel),
      .y  (rd)
  );
endmodule
