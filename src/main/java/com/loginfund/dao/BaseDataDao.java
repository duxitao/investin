package com.loginfund.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.loginfund.model.Account;
import com.loginfund.model.ContactInfo;
import com.loginfund.model.Country;
import com.loginfund.model.Field;
import com.loginfund.model.Info;
import com.loginfund.model.Payment;
import com.loginfund.model.PaymentMethod;
import com.loginfund.model.ReciveEmail;
import com.loginfund.model.Scale;

/**
 * 基础数据查询类
 * 
 * @author duxitao@126.com
 *
 */
public interface BaseDataDao {

	public List<Scale> getAllScale();

	public List<Field> getAllField();

	public List<Country> getAllCountry(@Param("countryList")String countryList);
	
	public List<PaymentMethod> getPaymentMethodByCoverage(@Param("coverage")String coverage);

	public List<Account> getAllCompany();

	public int addAccount(Account company);

	public int addInfo(Info info);

	public Account getAccountByEmail(String email);

	public Info getInfoByEmail(String email);

	public int getCreditCodeCount();

	public String getCreditCodeByrand(@Param("randNum") int randNum);

	public String getCreditCodeByemail(@Param("email") String email);

	public void updateCreditCode(@Param("email") String email, @Param("code") String code);

	public int checkCreditCode(@Param("code") String code);

	public int checkCreditCodeOfAccount(@Param("email") String email);

	public void addCreditCodeToAccount(@Param("email") String email, @Param("code") String code);

	public void createPayment(Payment payment);

	public Payment getPaymentByID(@Param("id") String id);

	public void updatePaymentStatus(@Param("id") String id, @Param("txn_id") String txn_id);

	public void updateAccountPaymentStatus(@Param("id") String id, @Param("amount") String amount);

	public void updateCreditCodeStatus(@Param("id") String id);

	public void updateRequestStatus(@Param("amount") String amount, @Param("tel") String tel,
			@Param("email") String email);

	public void updateAccount(@Param("id") String account_id, @Param("tel") String tel, @Param("email") String email);

	public void updateInfo(@Param("id") String info_id, @Param("scaleId") String scaleId, @Param("email") String email);
	
	public void addContactInfo(ContactInfo contactInfo);

	public ReciveEmail getReceiveEmail(int countryId);
	
	public String getPaymentStatus(String id);
}
