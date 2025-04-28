document.addEventListener('DOMContentLoaded', function () {
  const productSelect = document.getElementById('product');
  const productSeriesSelect = document.getElementById('product-series');
  const machineSelect = document.getElementById('machine');
  const machineNoSelect = document.getElementById('machine-no');

  productSelect.addEventListener('change', (e) => {
    const selectedProduct = e.target.value;
    console.log(`Selected Product: ${selectedProduct}`);
    updateProductSeriesOptions(selectedProduct);
  });

  productSeriesSelect.addEventListener('change', (e) => {
    const selectedProductSeries = e.target.value;
    console.log(`Selected Product Series: ${selectedProductSeries}`);
    updateMachineOptions(selectedProductSeries);
  });

  machineSelect.addEventListener('change', (e) => {
    const selectedMachine = e.target.value;
    console.log(`Selected Machine: ${selectedMachine}`);
    updateMachineNoOptions(selectedMachine);
  });

  function updateProductSeriesOptions(selectedProduct) {
    let productSeriesOptions = [];

    if (selectedProduct === 'LQW') {
      productSeriesOptions = [
        { value: '', text: 'Choose Product Series' },
        { value: 'LQW04A', text: 'LQW04A' },
        { value: 'LQW15A', text: 'LQW15A' },
        { value: 'LQW15A_80', text: 'LQW15A_80' },
        { value: 'LQW18A', text: 'LQW18A' }
      ];
    } else if (selectedProduct === 'DLW') {
      productSeriesOptions = [
        { value: '', text: 'Choose Product Series' },
        { value: 'DLW21', text: 'DLW21' },
        { value: 'DLW32', text: 'DLW32' },
        { value: 'DLW43', text: 'DLW43' },
        { value: 'F-PLATE', text: 'F-PLATE' },
        { value: 'CORE MAKING', text: 'CORE MAKING' }
      ];
    } else if (selectedProduct === 'PLT') {
      productSeriesOptions = [
        { value: '', text: 'Choose Product Series' },
        { value: 'PLT', text: 'PLT' }
      ];
    }
      else if (selectedProduct === 'LQH') {
      productSeriesOptions = [
        { value: '', text: 'Choose Product Series' },
        { value: 'LQHM', text: 'LQHM' },
        { value: 'LQH2', text: 'LQH2' },
        { value: 'LQH', text: 'LQH' }
      ];
    }

    updateSelectOptions(productSeriesSelect, productSeriesOptions);
    updateSelectOptions(machineSelect, []); // Reset machine options
    updateSelectOptions(machineNoSelect, []); // Reset machine no options
  }

  function updateMachineOptions(selectedProductSeries) {
    let machineOptions = [];

   if (selectedProductSeries === 'LQW04A') {
    machineOptions = [{ value: '', text: 'Choose Machine' }, { value: 'EST', text: 'EST' }, { value: 'AOI', text: 'AOI' }];
} else if (selectedProductSeries === 'LQW15A') {
    machineOptions = [{ value: '', text: 'Choose Machine' }, { value: 'EST', text: 'EST' }, { value: 'AOI', text: 'AOI' }];
} else if (selectedProductSeries === 'LQW15A_80') {
    machineOptions = [{ value: '', text: 'Choose Machine' }, { value: 'EST', text: 'EST' }];
} else if (selectedProductSeries === 'LQW18A') {
    machineOptions = [{ value: '', text: 'Choose Machine' }, { value: 'EST', text: 'EST' }, { value: 'AOI', text: 'AOI' }];
}
     else if (selectedProductSeries === 'DLW21') {
      machineOptions = [
        { value: '', text: 'Choose Machine' },
        { value: 'AIM', text: 'AIM' },
        { value: 'EST', text: 'EST' },
        { value: 'AOI', text: 'AOI' }
        
      ];
    } else if (selectedProductSeries === 'DLW32') {
      machineOptions = [
        { value: '', text: 'Choose Machine' },
        { value: 'YCW', text: 'YCW' },
        { value: 'RAM', text: 'RAM' },
        { value: 'EST', text: 'EST' },
        { value: 'AOI', text: 'AOI' }
      ];
    } else if (selectedProductSeries === 'DLW43') {
      machineOptions = [
        { value: '', text: 'Choose Machine' },
        { value: 'YCW', text: 'YCW' },
        { value: 'RAM', text: 'RAM' },
        { value: 'EST', text: 'EST' },
        { value: 'IAT', text: 'IAT' },
        { value: 'AOI', text: 'AOI' }
      ];
    } 
    
      else if (selectedProductSeries === 'F-PLATE') {
    machineOptions = [{ value: '', text: 'Choose Machine' }, { value: 'AOI', text: 'AOI' }];
      }
          else if (selectedProductSeries === 'CORE MAKING') {
    machineOptions = [{ value: '', text: 'Choose Machine' }, { value: 'AOI', text: 'AOI' }];
      }  
      
      else if (selectedProductSeries === 'PLT') {
        
      machineOptions = [{ value: '', text: 'Choose Machine' },{ value: 'EST', text: 'EST' }];
    }
 else if (selectedProductSeries === 'LQHM' ) {
      machineOptions = [
        { value: '', text: 'Choose Machine' },
        { value: 'YCW', text: 'YCW' },
        { value: 'CCM', text: 'CCM' },
        { value: 'DSM', text: 'DSM' },
        { value: 'EST', text: 'EST' },
        { value: 'VIM', text: 'VIM' }
      ];
}
else if ( selectedProductSeries === 'LQH2' ) {
      machineOptions = [
        { value: '', text: 'Choose Machine' },
        { value: 'YCW', text: 'YCW' },
        { value: 'CCM', text: 'CCM' },
        { value: 'EST', text: 'EST' },
        { value: 'VIM', text: 'VIM' }
      ];
  }
  else if ( selectedProductSeries === 'LQH' ) {
      machineOptions = [
        { value: '', text: 'Choose Machine' },
        { value: 'AOI', text: 'AOI' }
      ];
  }
    updateSelectOptions(machineSelect, machineOptions);
    updateSelectOptions(machineNoSelect, []); // Reset machine no options
  }

function updateMachineNoOptions(selectedMachine) {
    let machineNoOptions = [];
    const selectedProductSeries = productSeriesSelect.value;
    console.log(`Updating Machine No Options for Series: ${selectedProductSeries}, Machine: ${selectedMachine}`);

    
        if (selectedProductSeries === 'LQW04A' && selectedMachine === 'EST') {
        machineNoOptions = [
            { value: 'K002', text: 'K002' },
            { value: 'KA012', text: 'KA012' },
            { value: 'KA007', text: 'KA007' },
            { value: 'AZ001', text: 'AZ001' },
            { value: 'KA008', text: 'KA008' },
            { value: 'AZ002', text: 'AZ002' },
            { value: 'KA009', text: 'KA009' },
            { value: 'AZ003', text: 'AZ003' },
            { value: 'KA010', text: 'KA010' },
            { value: 'AZ004', text: 'AZ004' },
            { value: 'KA011', text: 'KA011' },
            { value: 'AX009', text: 'AX009' }
        ];
    }
        if (selectedProductSeries === 'LQW04A' && selectedMachine === 'AOI') {
        machineNoOptions = [
            { value: 'AR4-01', text: 'AR4-01' },
            { value: 'AR4-02', text: 'AR4-02' },
            { value: 'AR4-03', text: 'AR4-03' },
            { value: 'AR4-04', text: 'AR4-04' },
            { value: 'AR4-05', text: 'AR4-05' }
        ];
    
    } else if (selectedProductSeries === 'LQW15A' && selectedMachine === 'EST') {
        machineNoOptions = [
            { value: '910', text: '910' },
            { value: '918', text: '918' },
            { value: '924', text: '924' },
            { value: '913', text: '913' },
            { value: '919', text: '919' },
            { value: '925', text: '925' },
            { value: '914', text: '914' },
            { value: '920', text: '920' },
            { value: '926', text: '926' },
            { value: '915', text: '915' },
            { value: '921', text: '921' },
            { value: '927', text: '927' },
            { value: '916', text: '916' },
            { value: '922', text: '922' },
            { value: '933', text: '933' },
            { value: '917', text: '917' },
            { value: '923', text: '923' },
            { value: '934', text: '934' }
        ];
    } 
     if (selectedProductSeries === 'LQW15A' && selectedMachine === 'AOI') {
        machineNoOptions = [
            { value: 'AR5-01', text: 'AR5-01' },
            { value: 'AR5-02', text: 'AR5-02' },
            { value: 'AR5-03', text: 'AR5-03' },
            { value: 'AR5-04', text: 'AR5-04' }
        ];
    
    } 
    else if (selectedProductSeries === 'LQW15A_80' && selectedMachine === 'EST') {
        machineNoOptions = [
            { value: 'AK001', text: 'AK001' },
            { value: '935', text: '935' },
            { value: '937', text: '937' }
        ];
    } else if (selectedProductSeries === 'LQW18A' && selectedMachine === 'EST') {
        machineNoOptions = [
            { value: 'X004', text: 'X004' },
            { value: '1504', text: '1504' },
            { value: 'X005', text: 'X005' },
            { value: '1512', text: '1512' },
            { value: 'AY001', text: 'AY001' },
            { value: '1520', text: '1520' },
            { value: 'AY002', text: 'AY002' },
            { value: '1522', text: '1522' }
        ];
    } 
    if (selectedProductSeries === 'LQW18A' && selectedMachine === 'AOI') {
        machineNoOptions = [
            { value: 'AR8-01', text: 'AR8-01' },
            { value: 'AR8-02', text: 'AR8-02' }
        ];
    
    } 
      
    else if (selectedProductSeries === 'DLW21' && selectedMachine === 'AIM') {
        machineNoOptions = [{ value: 'AIM', text: 'AIM' }];
    }
    
       
    else if (selectedProductSeries === 'DLW21' && selectedMachine === 'AOI') {
        machineNoOptions = [{ value: 'AD2-01', text: 'AD2-01' }];
    }
    
    else if (selectedProductSeries === 'DLW21' && selectedMachine === 'EST') {
        machineNoOptions = [
            { value: '161-1', text: '161-1' },
            { value: '165-3', text: '165-3' },
            { value: '161-2', text: '161-2' },
            { value: '165-4', text: '165-4' },
            { value: '163-1', text: '163-1' },
            { value: '165-5', text: '165-5' },
            { value: '163-2', text: '163-2' },
            { value: '166ME-1', text: '166ME-1' },
            { value: '165-1', text: '165-1' },
            { value: '171A', text: '171A' },
            { value: '165 -2', text: '165-2' }
        ];
        
    } 
    else if (selectedProductSeries === 'DLW32' && selectedMachine === 'AOI') {
        machineNoOptions = [{ value: 'AD3-01', text: 'AD3-01' }];
    }
    
    else if (selectedProductSeries === 'DLW32' && selectedMachine === 'YCW') {
        machineNoOptions = [
            { value: 'DM01', text: 'DM01' },
            { value: 'DM05', text: 'DM05' },
            { value: 'DM02', text: 'DM02' },
            { value: 'DM06', text: 'DM06' },
            { value: 'DM03', text: 'DM03' },
            { value: 'DM07', text: 'DM07' },
            { value: 'DM04', text: 'DM04' },
            { value: 'DM08', text: 'DM08' },
            { value: 'DM09', text: 'DM09' },
            { value: 'DM10', text: 'DM10' }
        ];
    } else if (selectedProductSeries === 'DLW32' && selectedMachine === 'RAM') {
        machineNoOptions = [
            { value: 'RM01', text: 'RM01' },
            { value: 'RM02', text: 'RM02' },
            { value: 'RM03', text: 'RM03' },
            { value: 'RM04', text: 'RM04' },
            { value: 'RM05', text: 'RM05' },
            { value: 'RM06', text: 'RM06' }
        ];
    } else if (selectedProductSeries === 'DLW32' && selectedMachine === 'EST') {
        machineNoOptions = [{ value: 'CM01', text: 'CM01' }];
    } else if (selectedProductSeries === 'DLW43' && selectedMachine === 'YCW') {
        machineNoOptions = [
         
    { value: 'AM01', text: 'AM01' },
    { value: 'AM02', text: 'AM02' },
    { value: 'AM03', text: 'AM03' },
    { value: 'AM04', text: 'AM04' },
    { value: 'AM05', text: 'AM05' },
    { value: 'AM06', text: 'AM06' },
    { value: 'AM07', text: 'AM07' },
    { value: 'AM08', text: 'AM08' },
    { value: 'AM09', text: 'AM09' },
    { value: 'AM12', text: 'AM12' },
    { value: 'AM13', text: 'AM13' },
    { value: 'AM14', text: 'AM14' },
    { value: 'AM15', text: 'AM15' },
    { value: 'AM16', text: 'AM16' },
    { value: 'AM18', text: 'AM18' },
    { value: 'AM21', text: 'AM21' },
    { value: 'AM23', text: 'AM23' },
    { value: 'AM26', text: 'AM26' },
    { value: 'AM27', text: 'AM27' },
    { value: 'AM29', text: 'AM29' },
    { value: 'AM30', text: 'AM30' },
    { value: 'AM31', text: 'AM31' },
    { value: 'AM33', text: 'AM33' },
    { value: 'AM34', text: 'AM34' },
    { value: 'AM35', text: 'AM35' },
    { value: 'AM36', text: 'AM36' },
    { value: 'AM37', text: 'AM37' },
    { value: 'AM38', text: 'AM38' },
    { value: 'AM40', text: 'AM40' },
    { value: 'AM41', text: 'AM41' },
    { value: 'AM42', text: 'AM42' },
    { value: 'AM43', text: 'AM43' },
    { value: 'AM44', text: 'AM44' },
    { value: 'AM47', text: 'AM47' },
    { value: 'AM48', text: 'AM48' },
    { value: 'AM49', text: 'AM49' },
    { value: 'AM50', text: 'AM50' },
    { value: 'AM52', text: 'AM52' },
    { value: 'AM53', text: 'AM53' },
    { value: 'AM54', text: 'AM54' },
    { value: 'AM55', text: 'AM55' },
    { value: 'AM56', text: 'AM56' },
    { value: 'AM62', text: 'AM62' },
    { value: 'AM63', text: 'AM63' },
    { value: 'AM64', text: 'AM64' },
    { value: 'AM69', text: 'AM69' },
    { value: 'AM71', text: 'AM71' },
    { value: 'AM73', text: 'AM73' },
    { value: 'AM74', text: 'AM74' },
    { value: 'AM75', text: 'AM75' },
    { value: 'AMM01', text: 'AMM01' },
    { value: 'AMM02', text: 'AMM02' },
    { value: 'AMM03', text: 'AMM03' },
    { value: 'AMM04', text: 'AMM04' },
    { value: 'AMM05', text: 'AMM05' },
    { value: 'AMM06', text: 'AMM06' },
    { value: 'AMM07', text: 'AMM07' },
    { value: 'AMM08', text: 'AMM08' },
    { value: 'AMM09', text: 'AMM09' },
    { value: 'AMM10', text: 'AMM10' },
    { value: 'AMM11', text: 'AMM11' },
    { value: 'AMM12', text: 'AMM12' },
    { value: 'AMM13', text: 'AMM13' },
    { value: 'AMM14', text: 'AMM14' },
    { value: 'AMM15', text: 'AMM15' },
    { value: 'AMM16', text: 'AMM16' },
    { value: 'AMM17', text: 'AMM17' },
    { value: 'AMM18', text: 'AMM18' },
    { value: 'AMM19', text: 'AMM19' }

          ];
       } else if (selectedProductSeries === 'DLW43' && selectedMachine === 'RAM') {
        machineNoOptions = [
            { value: 'R401M', text: 'R401M' },
            { value: 'R401', text: 'R401' },
            { value: 'R408', text: 'R408' },
            { value: 'R402M', text: 'R402M' },
            { value: 'R411', text: 'R411' },
            { value: 'R403M', text: 'R403M' },
            { value: 'R412', text: 'R412' },
            { value: 'R404M', text: 'R404M' },
            { value: 'R413', text: 'R413' },
            { value: 'R403', text: 'R403' },
            { value: 'R406', text: 'R406' },
            { value: 'R415', text: 'R415' },
            { value: 'R407', text: 'R407' }
          ];
           } else if (selectedProductSeries === 'DLW43' && selectedMachine === 'EST') {
        machineNoOptions = [
            { value: '167-1', text: '167-1' },
            { value: '167-7', text: '167-7' },
            { value: '167-2', text: '167-2' },
            { value: '168M-1', text: '168M-1' },
            { value: '167-4', text: '167-4' },
            { value: '168M-2', text: '168M-2' },
            { value: '167-5', text: '167-5' },
            { value: '168M-3', text: '168M-3' },
            { value: '168M-4', text: '168M-4' },
            { value: '167-6', text: '167-6' }
          ];
         } else if (selectedProductSeries === 'DLW43' && selectedMachine === 'IAT') {
        machineNoOptions = [
            { value: '20-04', text: '20-04' },
            { value: '20-05', text: '20-05' },
            { value: '20-11', text: '20-11' },
            { value: '20-06', text: '20-06' },
            { value: '20-15', text: '20-15' },
            { value: '20-07', text: '20-07' },
            { value: '20-16', text: '20-16' },
            { value: '20-08', text: '20-08' },
            { value: '20-17', text: '20-17' },
            { value: '20-09', text: '20-09' },
            { value: '20-18', text: '20-18' },
            { value: '20-10', text: '20-10' },
            { value: '20-19', text: '20-19' }
          ];
        }
        
        else if (selectedProductSeries === 'DLW43' && selectedMachine === 'AOI') {
        machineNoOptions = [
            { value: 'ADM-01', text: 'ADM-01' },
            { value: 'AD4-01', text: 'AD4-01' },
            { value: 'AD4-02', text: 'AD4-02' },
            { value: 'AD4-03', text: 'AD4-03' }
          ];
        }
        
          else if (selectedProductSeries === 'F-PLATE' && selectedMachine === 'AOI') {
        machineNoOptions = [
            { value: 'ADF-01', text: 'ADF-01' },
            { value: 'ADF-02', text: 'ADF-02' },
            { value: 'ADF-03', text: 'ADF-03' },
            { value: 'ADF-04', text: 'ADF-04' }
          ];
        }
        
         else if (selectedProductSeries === 'F-PLATE' && selectedMachine === 'AOI') {
        machineNoOptions = [
            { value: 'ADF-01', text: 'ADF-01' },
            { value: 'ADF-02', text: 'ADF-02' },
            { value: 'ADF-03', text: 'ADF-03' },
            { value: 'ADF-04', text: 'ADF-04' }
          ];
        }
        
       else if (selectedProductSeries === 'PLT' && selectedMachine === 'EST') {
        machineNoOptions = [
          { value: 'LINE 2', text: 'LINE 2' },
          { value: 'LINE 3', text: 'LINE 3' },
          { value: 'LINE 4', text: 'LINE 4' },
          { value: 'LINE 4', text: 'LINE 5' }
        ];
      }
else if (selectedProductSeries === 'CORE MAKING' && selectedMachine === 'AOI') {
        machineNoOptions = [
            { value: 'ACM-ME01', text: 'ACM-ME01' }
          ];
        }
 else if (selectedProductSeries === 'LQHM' && selectedMachine === 'CCM') {
        machineNoOptions = [
            { value: 'C01', text: 'C01' },
            { value: 'C02', text: 'C02' },
            { value: 'C03', text: 'C03' },
            { value: 'C04', text: 'C04' },
            { value: 'C05', text: 'C05' },
            { value: 'C06', text: 'C06' },
            { value: 'C07', text: 'C07' },
            { value: 'C08', text: 'C08' },
            { value: 'C10', text: 'C10' },
            { value: 'C11', text: 'C11' },
            { value: 'C12', text: 'C12' },
            { value: 'C13', text: 'C13' },
            { value: 'C14', text: 'C14' },
            { value: 'C15', text: 'C15' },
            { value: 'C16', text: 'C16' },
            { value: 'C17', text: 'C17' },
            { value: 'C18', text: 'C18' },
            { value: 'C19', text: 'C19' },
            { value: 'C20', text: 'C20' },
            { value: 'C21', text: 'C21' },
            { value: 'C22', text: 'C22' },
            { value: 'C23', text: 'C23' },
            { value: 'C24', text: 'C24' },
            { value: 'C25', text: 'C25' },
            { value: 'C27', text: 'C27' }
          ];
        }
else if (selectedProductSeries === 'LQHM' && selectedMachine === 'DSM') {
        machineNoOptions = [
            { value: 'D01', text: 'D01' },
            { value: 'D02', text: 'D02' },
            { value: 'D03', text: 'D03' },
            { value: 'D04', text: 'D04' },
            { value: 'D05', text: 'D05' },
            { value: 'D06', text: 'D06' },
            { value: 'D07', text: 'D07' },
            { value: 'D08', text: 'D08' }
          ];
        }
         else if (selectedProductSeries === 'LQHM' && selectedMachine === 'EST') {
        machineNoOptions = [
            { value: 'E01', text: 'E01' },
            { value: 'E02', text: 'E02' },
            { value: 'E03', text: 'E03' },
            { value: 'E04', text: 'E04' },
            { value: 'E05', text: 'E05' },
            { value: 'E06', text: 'E06' },
            { value: 'E07', text: 'E07' },
            { value: 'E08', text: 'E08' },
            { value: 'E09', text: 'E09' },
            { value: 'E10', text: 'E10' },
            { value: 'E11', text: 'E11' },
            { value: 'E12', text: 'E12' },
            { value: 'E13', text: 'E13' },
            { value: 'E14', text: 'E14' },
            { value: 'E15', text: 'E15' },
            { value: 'E16', text: 'E16' },
            { value: 'E17', text: 'E17' },
            { value: 'E18', text: 'E18' },
            { value: 'E19', text: 'E19' },
            { value: 'E20', text: 'E20' },
            { value: 'E21', text: 'E21' }
          ];
        }
else if (selectedProductSeries === 'LQHM' && selectedMachine === 'VIM') {
        machineNoOptions = [
            { value: 'V01', text: 'V01' },
            { value: 'V04', text: 'V04' },
            { value: 'V05', text: 'V05' },
            { value: 'V06', text: 'V06' },
            { value: 'V07', text: 'V07' }
          ];
        }
        
      else if (selectedProductSeries === 'LQHM' && selectedMachine === 'YCW') {
    machineNoOptions = [
        { value: 'W01', text: 'W01' },
        { value: 'W03', text: 'W03' },
        { value: 'W09', text: 'W09' },
        { value: 'W12', text: 'W12' },
        { value: 'W13', text: 'W13' },
        { value: 'W14', text: 'W14' },
        { value: 'W15', text: 'W15' },
        { value: 'W16', text: 'W16' },
        { value: 'W17', text: 'W17' },
        { value: 'W23', text: 'W23' },
        { value: 'W24', text: 'W24' },
        { value: 'W25', text: 'W25' },
        { value: 'W26', text: 'W26' }
    ];
}
        
        else if (selectedProductSeries === 'LQH2' && selectedMachine === 'YCW') {
        machineNoOptions = [
            { value: 'N02', text: 'N02' },
            { value: 'N03', text: 'N03' },
            { value: 'N06', text: 'N06' },
            { value: 'N12', text: 'N12' }
          ];
        }
        else if (selectedProductSeries === 'LQH2' && selectedMachine === 'CCM') {
        machineNoOptions = [
            { value: '500-09', text: '500-09' },
            { value: '500-18', text: '500-18' },
            { value: 'C09', text: 'C09' },
            { value: 'P01', text: 'P01' },
            { value: 'P03', text: 'P03' },
            { value: 'P07', text: 'P07' },
            { value: 'P10', text: 'P10' }
            
          ];
        }     
 
        else if (selectedProductSeries === 'LQH2' && selectedMachine === 'EST') {
        machineNoOptions = [
            { value: 'MST 500-02', text: 'MST 500-02' },
            { value: 'T01', text: 'T01' },
            { value: 'T02', text: 'T02' },
            { value: 'T03', text: 'T03' }
            
          ];
        }
        else if (selectedProductSeries === 'LQH2' && selectedMachine === 'VIM') {
        machineNoOptions = [
           { value: 'V02', text: 'V02' },
           { value: 'V03', text: 'V03' }
            
          ];
        }
           else if (selectedProductSeries === 'LQH' && selectedMachine === 'AOI') {
        machineNoOptions = [
           { value: 'AOI DM', text: 'AOI DM' }
            
          ];
        }
        
      updateSelectOptions(machineNoSelect, machineNoOptions);
    }
  });

  function updateSelectOptions(selectElement, options) {
    selectElement.innerHTML = '';
    options.forEach((option) => {
      const optionElement = document.createElement('option');
      optionElement.value = option.value;
      optionElement.text = option.text;
      selectElement.appendChild(optionElement);
    });
  }
