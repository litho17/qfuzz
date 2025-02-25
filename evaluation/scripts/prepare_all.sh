trap "exit" INT

declare -a subjects=(
 #
 # Eclipse Jetty
 "Eclipse_jetty_1_eps1_1"
 "Eclipse_jetty_1_eps1_2"
 "Eclipse_jetty_1_eps1_3"
 "Eclipse_jetty_1_eps1_4"
 "Eclipse_jetty_1_eps1_5"
 "Eclipse_jetty_1_eps4_1"
 "Eclipse_jetty_1_eps4_2"
 "Eclipse_jetty_1_eps4_3"
 "Eclipse_jetty_1_eps4_4"
 "Eclipse_jetty_1_eps4_5"
 "Eclipse_jetty_4_eps1_1"
 "Eclipse_jetty_4_eps1_2"
 "Eclipse_jetty_4_eps1_3"
 "Eclipse_jetty_4_eps1_4"
 "Eclipse_jetty_4_eps1_5"
 "Eclipse_jetty_4_eps4_1"
 "Eclipse_jetty_4_eps4_2"
 "Eclipse_jetty_4_eps4_3"
 "Eclipse_jetty_4_eps4_4"
 "Eclipse_jetty_4_eps4_5"
 "Eclipse_jetty_5_eps1_1"
 "Eclipse_jetty_5_eps1_2"
 "Eclipse_jetty_5_eps1_3"
 "Eclipse_jetty_5_eps1_4"
 "Eclipse_jetty_5_eps1_5"
 "Eclipse_jetty_5_eps4_1"
 "Eclipse_jetty_5_eps4_2"
 "Eclipse_jetty_5_eps4_3"
 "Eclipse_jetty_5_eps4_4"
 "Eclipse_jetty_5_eps4_5"
 #
 # Leaks Set
 "leaksn1b-1_1"
 "leaksn1b-1_2"
 "leaksn1b-1_3"
 "leaksn1b-1_4"
 "leaksn1b-1_5"
 "leaksn1b-2_1"
 "leaksn1b-2_2"
 "leaksn1b-2_3"
 "leaksn1b-2_4"
 "leaksn1b-2_5"
 "leaksn1b-3_1"
 "leaksn1b-3_2"
 "leaksn1b-3_3"
 "leaksn1b-3_4"
 "leaksn1b-3_5"
 "leaksn1b-4_1"
 "leaksn1b-4_2"
 "leaksn1b-4_3"
 "leaksn1b-4_4"
 "leaksn1b-4_5"
 "leaksn1b-5_1"
 "leaksn1b-5_2"
 "leaksn1b-5_3"
 "leaksn1b-5_4"
 "leaksn1b-5_5"
 #
 # Apache WSS4J
 "apache_wss4j"
 "apache_wss4j_1"
 "apache_wss4j_2"
 "apache_wss4j_3"
 "apache_wss4j_4"
 "apache_wss4j_5"
 #
 # Blazer
 "blazer_array_unsafe"
 "blazer_array_safe"
 "blazer_loopandbranch_unsafe"
 "blazer_loopandbranch_safe"
 "blazer_sanity_unsafe"
 "blazer_sanity_safe"
 "blazer_straightline_unsafe"
 "blazer_straightline_safe"
 "blazer_unixlogin_unsafe"
 "blazer_unixlogin_safe"
 "blazer_modpow1_unsafe"
 "blazer_modpow1_safe"
 "blazer_modpow2_unsafe"
 "blazer_modpow2_safe"
 "blazer_passwordEq_unsafe"
 "blazer_passwordEq_safe"
 "blazer_k96_unsafe"
 "blazer_k96_safe"
 "blazer_gpt14_unsafe"
 "blazer_gpt14_safe"
 "blazer_login_unsafe"
 "blazer_login_safe"
 #
 # Themis
 "themis_spring-security_unsafe"
 "themis_spring-security_safe"
 "themis_jdk_unsafe"
 "themis_jdk_safe"
 "themis_picketbox_unsafe"
 "themis_picketbox_safe"
 "themis_tomcat_unsafe"
 "themis_tomcat_safe"
 "themis_jetty_unsafe"
 "themis_jetty_safe"
 "themis_orientdb_unsafe"
 "themis_orientdb_safe"
 "themis_pac4j_unsafe"
 "themis_pac4j_safe"
 "themis_pac4j_unsafe_ext"
 "themis_boot-stateless-auth_unsafe"
 "themis_boot-stateless-auth_safe"
 "themis_tourplanner_unsafe"
 "themis_tourplanner_safe"
 "themis_dynatable_unsafe"
 "themis_GWT_advanced_table_unsafe"
 "themis_openmrs-core_unsafe"
 "themis_oacc_unsafe"
 #
 # DifFuzz
 "stac_crime_unsafe"
 "stac_ibasys_unsafe"
 "apache_ftpserver_clear_safe"
 "apache_ftpserver_clear_unsafe"
 "apache_ftpserver_md5_safe"
 "apache_ftpserver_md5_unsafe"
 "apache_ftpserver_salted_safe"
 "apache_ftpserver_salted_unsafe"
 "apache_ftpserver_salted_encrypt_unsafe"
 "apache_ftpserver_stringutils_safe"
 "apache_ftpserver_stringutils_unsafe"
 "github_authmreloaded_safe"
 "github_authmreloaded_unsafe"
 #
 # RSA
 "rsa_modpow_1717_bitlength_3_count"
 "rsa_modpow_1717_bitlength_4_count"
 "rsa_modpow_1717_bitlength_5_count"
 "rsa_modpow_1717_bitlength_6_count"
 "rsa_modpow_1717_bitlength_7_count"
 "rsa_modpow_1717_bitlength_8_count"
 "rsa_modpow_1717_bitlength_9_count"
 "rsa_modpow_1717_bitlength_10_count"
 "rsa_modpow_834443_bitlength_3_count"
 "rsa_modpow_834443_bitlength_4_count"
 "rsa_modpow_834443_bitlength_5_count"
 "rsa_modpow_834443_bitlength_6_count"
 "rsa_modpow_834443_bitlength_7_count"
 "rsa_modpow_834443_bitlength_8_count"
 "rsa_modpow_834443_bitlength_9_count"
 "rsa_modpow_834443_bitlength_10_count"
 "rsa_modpow_1964903306_bitlength_3_count"
 "rsa_modpow_1964903306_bitlength_4_count"
 "rsa_modpow_1964903306_bitlength_5_count"
 "rsa_modpow_1964903306_bitlength_6_count"
 "rsa_modpow_1964903306_bitlength_7_count"
 "rsa_modpow_1964903306_bitlength_8_count"
 "rsa_modpow_1964903306_bitlength_9_count"
 "rsa_modpow_1964903306_bitlength_10_count"
 #
 )

 run_counter=0
 total_number_subjects=${#subjects[@]}
 echo

 cd ../subjects

 for (( i=0; i<=$(( $total_number_subjects - 1 )); i++ ))
 do
   run_counter=$(( $run_counter + 1 ))
   echo "[$run_counter/$total_number_subjects] Prepare ${subjects[i]}.."

   cd ./${subjects[i]}/
   rm -rf bin
   mkdir bin
   cd src
   javac -cp ".:../../../../tool/instrumentor/build/libs/kelinci.jar:../lib/*" *.java -d ../bin
   cd ..
   rm -rf bin-instr
   java -cp "../../../tool/instrumentor/build/libs/kelinci.jar:lib/*" edu.cmu.sv.kelinci.instrumentor.Instrumentor -mode LABELS -i ./bin/ -o ./bin-instr -skipmain
   cd ..
   echo

 done

 echo ">> Finished preparing the experiment subjects."
