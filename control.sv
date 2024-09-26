
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
                next_state = LOADB;
         else 
           next_state = START;
              

          LOADB: next_state = CXA;
           next_state = CXA;
         
          CXA:  
            if(run)
              next_state = AS0;
            else 
              next_state = CXA
  
            AS0: next_state = AS1;  
            AS1: next_state = AS2;
            AS2: next_state = AS3;
            AS3: next_state = AS4;     
            AS4: next_state = AS5;          
            AS5: next_state = AS6;                 
            AS6: next_state = SS;           
            SS: next_state = HALT;

          HALT: 
            if(posedge run)
            next_state = CXA;
         else 
           next_state = HALT;

              

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

