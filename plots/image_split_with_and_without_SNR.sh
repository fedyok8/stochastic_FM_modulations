# "imagemagick" package required
output_dir_name="splitted/"

if [ ! -d "${output_dir_name}" ]
then
    mkdir ${output_dir_name}
fi

input2=fmconst+N.png
input1=fmconst.png
output=splitted_fmconst.png
montage $input1 $input2 -tile 1x2 -geometry +0+0 "${output_dir_name}${output}"

input2=fmhyp+N.png
input1=fmhyp.png
output=splitted_fmhyp.png
montage $input1 $input2 -tile 1x2 -geometry +0+0 "${output_dir_name}${output}"

input2=fmlin+N.png
input1=fmlin.png
output=splitted_fmlin.png
montage $input1 $input2 -tile 1x2 -geometry +0+0 "${output_dir_name}${output}"

input2=fmodany+N.png
input1=fmodany.png
output=splitted_fmodany.png
montage $input1 $input2 -tile 1x2 -geometry +0+0 "${output_dir_name}${output}"

input2=fmpar-NARG2+N.png
input1=fmpar-NARG2.png
output=splitted_fmpar-NARG2.png
montage $input1 $input2 -tile 1x2 -geometry +0+0 "${output_dir_name}${output}"

input2=fmpar-NARG4+N.png
input1=fmpar-NARG4.png
output=splitted_fmpar-NARG4.png
montage $input1 $input2 -tile 1x2 -geometry +0+0 "${output_dir_name}${output}"

input2=fmpower-F0C+N.png
input1=fmpower-F0C.png
output=splitted_fmpower-F0C.png
montage $input1 $input2 -tile 1x2 -geometry +0+0 "${output_dir_name}${output}"

input2=fmpower-P12+N.png
input1=fmpower-P12.png
output=splitted_fmpower-P12.png
montage $input1 $input2 -tile 1x2 -geometry +0+0 "${output_dir_name}${output}"

input2=fmsin-complcted+N.png
input1=fmsin-complcted.png
output=splitted_fmsin-complcted.png
montage $input1 $input2 -tile 1x2 -geometry +0+0 "${output_dir_name}${output}"

input2=fmsin-simpl+N.png
input1=fmsin-simpl.png
output=splitted_fmsin-simpl.png
montage $input1 $input2 -tile 1x2 -geometry +0+0 "${output_dir_name}${output}"

input2=gdpower-K05+N.png
input1=gdpower-K05.png
output=splitted_gdpower-K05.png
montage $input1 $input2 -tile 1x2 -geometry +0+0 "${output_dir_name}${output}"

input2=gdpower-K0+N.png
input1=gdpower-K0.png
output=splitted_gdpower-K0.png
montage $input1 $input2 -tile 1x2 -geometry +0+0 "${output_dir_name}${output}"

input2=gdpower-K2+N.png
input1=gdpower-K2.png
output=splitted_gdpower-K2.png
montage $input1 $input2 -tile 1x2 -geometry +0+0 "${output_dir_name}${output}"

input2=gdpower-K1+N.png
input1=gdpower-K1.png
output=splitted_gdpower-K1.png
montage $input1 $input2 -tile 1x2 -geometry +0+0 "${output_dir_name}${output}"
