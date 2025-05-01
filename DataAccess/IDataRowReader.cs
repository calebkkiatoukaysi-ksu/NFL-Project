namespace DataAccess
{
   public interface IDataRowReader
   {
      bool Read();

      decimal GetDecimal(string name);

        long GetInt64(string name);
        
      bool GetBoolean(string name);
      byte GetByte(string name);
      DateTime GetDateTime(string name, DateTimeKind kind);
      DateTimeOffset GetDateTimeOffset(string name);
      int GetInt32(string name);
      string GetString(string name);
      T GetValue<T>(string name);
      T GetValue<T>(string name, T ifDbNull);
   }
}