Convert all character variables to numeric and use the same variable names
 
   To solutions
 
       a. Ted Clay's do_over and array macros
 
       b. Barts do_over and array macros
          Bartosz Jablonski yabwon@gmail.com
 
Github
https://tinyurl.com/sdw2eczx
https://github.com/rogerjdeangelis/utl-Convert-all-character-variables-to-numeric-and-use-the-same-variable-names
 
SAS Forum
https://tinyurl.com/3wsb33ke
https://communities.sas.com/t5/SAS-Programming/Convert-all-character-variables-to-numeric-and-use-the-same/m-p/720186
 
*_                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;
 
data have; /* Example of actual data set */
    input (a b c d e) ($);
    cards4;
1 1 1 1 1
;;;;
run;quit;
 
 
 Variables in Creation Order
 
#    Variable    Type    Len
 
1    A           Char      8
2    B           Char      8
3    C           Char      8
4    D           Char      8
5    E           Char      8
 
*
 _ __  _ __ ___   ___ ___  ___ ___
| '_ \| '__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
;
 
*          _____        _
  __ _    |_   _|__  __| |
 / _` |     | |/ _ \/ _` |
| (_| |_    | |  __/ (_| |
 \__,_(_)   |_|\___|\__,_|
 
;
 
%array(chrs,values=%varlist(have));
 
proc sql;
  create
    table want as
  select
    %do_over(chrs,phrase=%str(
       input(?,best.) as ?) ,between=comma)
  from
    have
;quit;
 
%arraydelete(chrs);
 
*_        ____             _
| |__    | __ )  __ _ _ __| |_
| '_ \   |  _ \ / _` | '__| __|
| |_) |  | |_) | (_| | |  | |_
|_.__(_) |____/ \__,_|_|   \__|
 
;
 
filename packages "%sysfunc(pathname(work))";
filename SPFinit url "https://raw.githubusercontent.com/yabwon/SAS_PACKAGES/main/SPF/SPFinit.sas";
%include SPFinit; /* enable the framework */
 
%installPackage(MacroArray BasePlus) /* install the packages */
%loadPackageS(MacroArray, BasePlus)  /* load packages content into the SAS session */
 
%put &=sysLoadedPackages.;
 
data have; /* Example of actual data set */
  input (a b c d e) ($);
cards4;
1 1 1 1 1
;;;;
run;
proc contents data = have;
run;
 
/* %helpPackage(BasePlus, '%getVars()') */
%getVars(have, varRange = _character_, mcArray = chrs)
 
proc sql;
  create table want as
  select
    /* %helpPackage(MacroArray, '%do_over()') */
    %do_over(chrs
      ,phrase  = %nrstr(input(%chrs(&_I_.), best.) as %chrs(&_I_.))
      ,between = %str(,)
    )
  from
    have
;
quit;
proc contents data = want;
run;
 
%unloadPackage(BasePlus)
%unloadPackage(MacroArray)
 
%put &=sysLoadedPackages.;
 
*            _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| '_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
;
 
 Variables in Creation Order
 
#    Variable    Type    Len
 
1    A           Num       8
2    B           Num       8
3    C           Num       8
4    D           Num       8
5    E           Num       8

 
