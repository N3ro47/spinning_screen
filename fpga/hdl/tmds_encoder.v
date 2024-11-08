module tmds_encoder(
    input wire i_de,
    input  wire [1:0] i_c,
    input wire [7:0] i_data,
    output wire [0:9] o_channel,
);

reg cnt;
cnt <= 1'b0;
//count ones in input data
wire [3:0] N_ones = {3'b0,i_data[0]} + {3'b0,i_data[1]} + {3'b0,i_data[2]}
        + {3'b0,i_data[3]} + {3'b0,i_data[4]} + {3'b0,i_data[5]}
        + {3'b0,i_data[6]} + {3'b0,i_data[7]};

//decision to use xor or xnor
wire use_xnor = (d_ones > 4'd4) || ((d_ones == 4'd4) && (i_data[0] == 0));

wire [8:0] q_m;
assign q_m[0] = i_data[0];
assign q_m[1] = (use_xnor) ? (q_m[0] ~^ i_data[1]) : (q_m[0] ^ i_data[1]);
assign q_m[2] = (use_xnor) ? (q_m[1] ~^ i_data[2]) : (q_m[1] ^ i_data[2]);
assign q_m[3] = (use_xnor) ? (q_m[2] ~^ i_data[3]) : (q_m[2] ^ i_data[3]);
assign q_m[4] = (use_xnor) ? (q_m[3] ~^ i_data[4]) : (q_m[3] ^ i_data[4]);
assign q_m[5] = (use_xnor) ? (q_m[4] ~^ i_data[5]) : (q_m[4] ^ i_data[5]);
assign q_m[6] = (use_xnor) ? (q_m[5] ~^ i_data[6]) : (q_m[5] ^ i_data[6]);
assign q_m[7] = (use_xnor) ? (q_m[6] ~^ i_data[7]) : (q_m[6] ^ i_data[7]);
assign q_m[9] = (use_xnor) ? 0 : 1 ;


if (i_de == 0)
    begin
        cnt <= 1'b0;
        case(i_c)
            2'b00:   o_channel <= 10'b0010101011;
            2'b01:   o_channel <= 10'b1101010100;
            2'b10:   o_channel <= 10'b0010101010;
            default: o_channel <= 10'b1101010101;
        endcase;
    end
else
    begin
        
    end





endmodule