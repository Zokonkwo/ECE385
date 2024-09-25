
/*
NOTES:
  B --> multiplier
    This determines we either add a shifted version of the multiplicand to the accumulator or just shift without adding
  A --> Accumulator
    Holds intermiediate results of the multiplication as we add/subtract. 
    Should start at zero and accumulates shiftted multiplicand   
  S --> Multiplicand
    Number we are multiplying by the multiplier. Remains unchanged throughout the process. Shifted left by one
  After we are done multiplying the result should be stored in the Accumulator and Multiplier together. 
  X --> Carry bit
*/

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module controllerFSM (input Reset_Load_Clear, run, Clk, M,
                      output Shift, Add, Sub, Clr, LoadB);

    //declare signals curr_state, next_state of type enum
    enum logic [3:0] {START,LOADB,CXA,AS0,AS1,AS2,AS3,AS4,AS5,AS6,SS,HALT} curr_state, next_state;

    //assign outputs based on state
    always_comb
    begin 
      unique case(curr_state)
        START:
          begin
            Shift = 1'b0;
            Add = 1'b0;
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b0;  
          end
        LOADB:
          begin
            Shift = 1'b0;
            Add = 1'b0;
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b1;
            Bval[7:0] = sw_s[7:0];
          end
        CXA:
          begin
            Shift = 1'b0;
            Add = 1'b0;
            Sub = 1'b0;
            Clr = 1'b1; 
            LoadB = 1'b0; 
            Aval [9:0] = 0;
          end
        AS0:
          begin
            Shift = 1'b1;
             if(M == 1)
              Add = 1'b1;
            else
              Add = 1'b0;
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b0;  
          end
        AS1:
          begin
            Shift = 1'b1;
             if(M == 1)
              Add = 1'b1;
            else
              Add = 1'b0;
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b0;
          end
        AS2:
          begin
            Shift = 1'b1;
            if(M == 1)
              Add = 1'b1;
            else
              Add = 1'b0;
            Sub = 1'b0;
            Clr = 1'b0;  
            LoadB = 1'b0;
          end
        AS3:
          begin
            Shift = 1'b1;
             if(M == 1)
              Add = 1'b1;
            else
              Add = 1'b0;
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b0;  
          end
        AS4:
          begin
            Shift = 1'b1;
            if(M == 1)
              Add = 1'b1;
            else
              Add = 1'b0;
            Sub = 1'b0;
            Clr = 1'b0; 
            LoadB = 1'b0;
          end
        AS5:
          begin
            Shift = 1'b1; 
            if(M == 1)
              Add = 1'b1;
            else
              Add = 1'b0;
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b0;   
          end
        AS6:
          begin
            Shift = 1'b1;
             if(M == 1)
              Add = 1'b1;
            else
              Add = 1'b0; 
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b0; 
          end
        SS:
          begin
            Shift = 1'b1; 
            Add = 1'b0;
            Sub = 1'b1;
            Clr = 1'b0; 
            LoadB = 1'b0;
          end
        HALT:
          begin
            Shift = 1'b0;
            Add = 1'b0; 
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b0;  
          end
        default:  //default case, can also have default assignments 
          begin 
            Shift = 1'b0;
            Add = 1'b0; 
            Sub = 1'b0;
            Clr = 1'b0;
            LoadB = 1'b0;
          end
    end

    //next state logic
    always_comb
    begin
       unique case(curr_state)
          START: 
            if(Reset_Load_Clear)
              begin
                next_state = LOADB;
              end

          LOADB: next_state = CXA;

          CXA:  
            if(run)
              begin
                next_state = AS0;
              end
  
            AS0: next_state = AS1;  
            AS1: next_state = AS2;
            AS2: next_state = AS3;
            AS3: next_state = AS4;     
            AS4: next_state = AS5;          
            AS5: next_state = AS6;                 
            AS6: next_state = SS;           
            SS: next_state = HALT;

          HALT: 
            if(run)
              begin
                next_state = CXA;
              end

          default: next_state = START;

        endcase
    end

    //update flip-flops
    always_ff @ (posedge CLk)
    begin
      if (Reset_Load_Clear)       //Asychronous Reset
        curr_state <= START;       //A is the reset/start state
      else
        curr_state <= next_state;
    end

endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module add_sub5(input     [7:0] A, B,
                input       fn,
                output    [4:0] S);

    //useful shortcut - bit extension {4{fn}};

    if (fn == 1)
      //then inverting switches
      //after inverting call CRA 9 times
      //lastly add 1;
      //send result to A
      //send Cout from CRA to X
  

    else if (fn == 0)
      //then add switches normally as postive number
       //instantiate the CRA 9 times;
       //send result to A
       //send Cout from CRA to X

    
endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module reg_8(input logic      Clk, Reset, Shift_In, Load, Shift_En,
            input logic      [7:0] D,
            output logic     Shift_Out,
            output logic     [7:0] Data_Out);


    always_ff @ (posedge Clk)
    begin
      if(Reset)
        Data_Out <= 8'h0;
      else if (Load)
        Data_Out <= D;
      else if (Shift_En)
        Data_Out <= {Shift_In, Data_Out[7:1]};
    end
    
    assign Shift_Out = Data_Out[0];


 endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


