global class updateLeadBatch implements Database.Batchable<sObject> 
{
    global Database.QueryLocator start(Database.BatchableContext bc){
        
        return Database.getQueryLocator([SELECT AnnualRevenue FROM Lead]);
    }
    
    global void execute(Database.batchablecontext bc, List<Lead> lList){
        
        for (Lead l : lList){
            if(l.AnnualRevenue == null){
               l.AnnualRevenue = 100000;
            }
            update lList;
        }
    }
    
    global void finish(Database.batchablecontext bc){
       
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddress= new String[]{'sankalp.seth00@gmail.com', 'Shimona.seth25@gmail.com'};
        mail.setToAddresses(toAddress);
        mail.setSubject('Congratulations! Batch Apex work is done');
        mail.setPlainTextBody('Hi, your batch apex work is completed. you can go home and take rest now.');
        messaging.sendEmail(new messaging.SingleEmailMessage[]{mail});
        
    }

}