trigger UpdateDonationRating1 on contact (before insert,before update) 
{
  
    if(trigger.isInsert)
    {
      UpdateDonationRating1Handler.beforeinsert(trigger.new); 
    }
  else if(trigger.Isupdate)
    {
       UpdateDonationRating1Handler.beforeupdate(trigger.new,trigger.oldMap);  
    }
  }