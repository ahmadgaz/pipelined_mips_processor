module dreg #(
    parameter WIDTH = 32
) (
    input wire clk,
    input wire rst,
    input wire en,
    input  wire [WIDTH-1:0] d,
    output reg  [WIDTH-1:0] q
);
  always @(posedge clk, posedge rst) begin
    if (rst) begin
      `ifndef SYNTHESIS
      $display("%t: dreg: rst asserted, q reset to 0", $time);
      `endif
      q <= 0;
    end
    else if (en) q <= d;
  end
endmodule
