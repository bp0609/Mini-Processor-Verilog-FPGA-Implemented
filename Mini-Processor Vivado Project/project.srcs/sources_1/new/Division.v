module division(A, B, Res, Rem);
  parameter WIDTH = 8;
  input [WIDTH-1:0] A;
  input [WIDTH-1:0] B;
  output [WIDTH-1:0] Res;
  output reg [WIDTH-1:0] Rem;
  reg [WIDTH-1:0] Res;
  reg [WIDTH-1:0] a1, b1;
  reg [WIDTH:0] p1;
  integer i;

  always @(A or B)
    begin
      a1 = A;
      b1 = B;
      p1 = 0;

      for (i = 0; i < WIDTH; i = i + 1) begin
        p1 = {p1[WIDTH-2:0], a1[WIDTH-1]};
        a1[WIDTH-1:1] = a1[WIDTH-2:0];
        p1 = p1 - b1;

        if (p1[WIDTH-1] == 1'b1) begin
          a1[0] = 0;
          p1 = p1 + b1;
        end else begin
          a1[0] = 1;
        end
      end
      Res = a1;
      Rem = p1;
    end

endmodule