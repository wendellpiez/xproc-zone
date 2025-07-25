<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   type="zone:GRAB-FM6-22"
   name="GRAB-FM6-22" xmlns:zone="http://wendellpiez.com/ns/xproc-zone">
   
   <!-- https://armypubs.army.mil/epubs/DR_pubs/DR_a/ARN43044-FM_6-22-002-WEB-5.pdf -->
   
   <p:variable name="FM_6-22" select="'https://armypubs.army.mil/epubs/DR_pubs/DR_a/ARN43044-FM_6-22-002-WEB-5.pdf'"/>
   
   <!--   p:file-copy not working on remote PDF  -->
   <p:load href="{$FM_6-22}" message="[GRAB-FM6-22] Loading fm6_22.pdf ..."/>
   <p:store href="lib/fm6_22.pdf" message="[GRAB-FM6-22] Saving fm6_22.pdf"/>
      
</p:declare-step>