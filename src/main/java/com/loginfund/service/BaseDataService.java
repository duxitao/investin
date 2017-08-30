package com.loginfund.service;

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

public interface BaseDataService {

	public List<Scale> getAllScale();

	public List<Field> getAllField();

	public List<Country> getAllCountry(String countryList);
	
	public List<PaymentMethod> getPaymentMethodByCoverage(String coverage);

	public List<Account> getAllCompany();

	public boolean addCompany(Account company);

	public boolean addInfo(Info info);

	public void addAccountAndInfo(Account account, Info info);

	public Account getAccountByEmail(String email);

	public Info getInfoByEmail(String email);

	public String getCreditCodeByrand(String email);

	public String getCreditCodeByEmail(@Param("email") String email);

	public int checkCreditCode(String code);

	public void addCreditCodeToAccount(@Param("email") String email, @Param("code") String code);

	public int checkCreditCodeOfAccount(String email);

	public void createPayment(Payment payment);

	public Payment getPaymentByID(String id);

	public void updatePaymentSataus(String id, String txn_id, String amount);

	public void updateRequestStatus(String amount, String tel, String email);

	public void updateAccountAndInfo(String tel, String email, String scaleId, String account_id, String info_id);
	
	public void addContactInfo(ContactInfo contactInfo);
	
	public ReciveEmail getReceiveEmail(int countryId);
	
	public String getPaymentStatus(String id);
}
