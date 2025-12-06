module fact_dp (
    input clk,
    input load_cnt,
    input en,
    input sel_1,
    input load_reg,
    input sel_2,
    input [3:0] n,
    output gt_in,
    output gt_fact,
    output [3:0] nf
);
  wire [3:0] n_internal;
  wire [3:0] curr_prod;
  wire [3:0] mul_prod;
  wire [3:0] next_prod;
  assign gt_in = n > 12;
  assign gt_fact = n_internal > 1;
  assign mul_prod = curr_prod * n_internal;
  assign next_prod = (sel_1) ? 1 : mul_prod;
  assign nf = (sel_2) ? 0 : curr_prod;
  down_cnt #(
      .WIDTH(4)
  ) cnt (
      .clk(clk),
      .en(en),
      .load_cnt(load_cnt),
      .d(n),
      .q(n_internal)
  );
  dreg #(
      .WIDTH(4)
  ) register (
      .clk(clk),
      .rst(0),
      .en (load_reg),
      .d  (next_prod),
      .q  (curr_prod)
  );
endmodule
