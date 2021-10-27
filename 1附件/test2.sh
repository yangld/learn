#/bin/bash
#set -x

#ab=C
#ab=${ab^l}
#ab=`echo $ab | tr '[:upper:]' '[:lower:]' `
#echo $ab
#exit

IFS=$'\n'
allowed_suffix="ks;doc;docx;xls;xlsx;ppt;pptx;wps;dps;et;gif;jpeg;jpg;png;pdf;txt;csv;html;csr;pem;p12;cert;apk;ipa;log;zip;mp4;bmp"

for file in `find . -type f`
do
    if [[ "#file" == "~*" ]]
    then
        continue
    fi

    filename=$(basename "$file")
    ext="${filename##*.}"
    ext=`echo $ext | tr '[:upper:]' '[:lower:]'`

    found=0
    if [[ "$allowed_suffix" == *"$ext"* ]]
    then
        found=1
    fi

    curl -i -F "filename=@$file" http://192.168.11.119:9140/resources/api/v1/upload > logfile 2>&1
    egrep "400 Bad Request" logfile >/dev/null
    ret=$?
    #if [ $? -eq 0 ]
    #then
    #    ret=0
    #else
    #    ret=1
    #fi

    if [ $ret -eq $found ]
    then
        expected="OK"
    else
        expected="Failed"
    fi

    echo $filename ":" $expected "expected:" $found "real:" $ret
done


#curl -i -F "filename=@good.docx" http://192.168.11.119:9140/resources/api/v1/upload

#curl -i -F "filename=@good.doc" http://192.168.11.119:9140/resources/api/v1/upload

#curl -i -F "filename=@good.rar" http://192.168.11.119:9140/resources/api/v1/upload

#curl -i -F "filename=@bad.bmp" http://192.168.11.119:9140/resources/api/v1/upload
#curl -i -F "filename=@good.bmp" http://192.168.11.119:9140/resources/api/v1/upload
