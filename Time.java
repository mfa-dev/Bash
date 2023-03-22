import java.time.*;
import java.util.*;
import java.text.*;


public class Time {
  public static void main(String[] args) throws Exception {
//       OffsetDateTime now = OffsetDateTime.now( ZoneOffset.UTC );
//       System.out.println("hi" + now);
    TimeZone defTimeZone = TimeZone.getDefault();
    System.out.println("default TimeZone >> " + defTimeZone);

    Locale defLocale = Locale.getDefault();
    System.out.println("default Locale >> " + defLocale);

    TimeZone tz = TimeZone.getTimeZone("Asia/Tehran");
    TimeZone.setDefault(tz);

    Locale faLocale = Locale.forLanguageTag("fa_IR");

    Calendar cal = Calendar.getInstance(tz, faLocale); 
    DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm", faLocale);

    Date dateBeforeNewYear = df.parse("2023-02-25 01:55");
    cal.setTime(dateBeforeNewYear);
    System.out.println("before new year - zone offset: " + cal.get(Calendar.ZONE_OFFSET) / 3600000.0);
    System.out.println("before new year - DST offset: " + cal.get(Calendar.DST_OFFSET) / 3600000.0);

    Date dateAfterNewYear = df.parse("2023-04-25 01:55");
    cal.setTime(dateAfterNewYear);
    System.out.println("after new year - zone offset: " + cal.get(Calendar.ZONE_OFFSET) / 3600000.0);
    System.out.println("after new year - DST offset: " + cal.get(Calendar.DST_OFFSET) / 3600000.0);

  }
}

