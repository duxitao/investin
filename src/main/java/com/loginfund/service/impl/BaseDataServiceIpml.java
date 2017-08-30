package com.loginfund.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.loginfund.dao.BaseDataDao;
import com.loginfund.model.Account;
import com.loginfund.model.ContactInfo;
import com.loginfund.model.Country;
import com.loginfund.model.Field;
import com.loginfund.model.Info;
import com.loginfund.model.Payment;
import com.loginfund.model.PaymentMethod;
import com.loginfund.model.ReciveEmail;
import com.loginfund.model.Scale;
import com.loginfund.service.BaseDataService;

@Service
public class BaseDataServiceIpml implements BaseDataService {
	@Autowired
	BaseDataDao dao = null;

	public List<Scale> getAllScale() {
		return dao.getAllScale();
	}

	public List<Field> getAllField() {
		return dao.getAllField();
	}

	public List<Country> getAllCountry(String countryList) {
		return dao.getAllCountry(countryList);
	}

	public List<Account> getAllCompany() {
		return dao.getAllCompany();
	}

	public boolean addCompany(Account account) {
		return dao.addAccount(account) == 1 ? true : false;
	}

	public boolean addInfo(Info info) {
		return dao.addInfo(info) == 1 ? true : false;
	}

	@Transactional
	public void addAccountAndInfo(Account account, Info info) {
		dao.addAccount(account);
		dao.addInfo(info);
	}

	public Account getAccountByEmail(String email) {
		return dao.getAccountByEmail(email);
	}

	public Info getInfoByEmail(String email) {
		return dao.getInfoByEmail(email);
	}

	@Transactional
	public String getCreditCodeByrand(String email) {

		int randNum = (int) (Math.random() * dao.getCreditCodeCount());
		String code = dao.getCreditCodeByrand(randNum);
		dao.updateCreditCode(email, code);
		return code;
	}

	public String getCreditCodeByEmail(String email) {
		return dao.getCreditCodeByemail(email);
	}

	public int checkCreditCode(String code) {

		return dao.checkCreditCode(code);
	}

	public void addCreditCodeToAccount(String email, String code) {

		dao.addCreditCodeToAccount(email, code);
	}

	public int checkCreditCodeOfAccount(String email) {
		return dao.checkCreditCodeOfAccount(email);
	}

	public void createPayment(Payment payment) {
		dao.createPayment(payment);

	}

	public Payment getPaymentByID(String id) {
		return dao.getPaymentByID(id);
	}

	public void updatePaymentSataus(String id, String txn_id, String amount) {

		dao.updatePaymentStatus(id, txn_id);
		dao.updateAccountPaymentStatus(id, amount);
		dao.updateCreditCodeStatus(id);

	}

	public void updateRequestStatus(String amount, String tel, String email) {
		dao.updateRequestStatus(amount, tel, email);

	}

	@Transactional
	public void updateAccountAndInfo(String tel, String email, String scaleId, String account_id, String info_id) {
		if ("".equals(tel.trim()))
			tel = null;
		if ("".equals(email.trim()))
			email = null;
		if ("".equals(scaleId.trim()))
			scaleId = null;
		if (tel != null || email != null) {
			dao.updateAccount(account_id, tel, email);
		}
		if (scaleId != null || email != null) {
			dao.updateInfo(info_id, scaleId, email);
		}
	}

	public void addContactInfo(ContactInfo contactInfo) {
		dao.addContactInfo(contactInfo);
		
	}

	public ReciveEmail getReceiveEmail(int countryId) {
		
		return dao.getReceiveEmail(countryId);
	}

	public String getPaymentStatus(String id) {
		 return dao.getPaymentStatus(id);
	}

	public List<PaymentMethod> getPaymentMethodByCoverage(String coverage) {
		 return dao.getPaymentMethodByCoverage(coverage);
	}

}
