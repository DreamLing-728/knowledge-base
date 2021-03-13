58招聘接通率分析- AXG模式
select  
	to_char(CREATEDTIME,'yyyy-mm-dd') 日期,  
	count(*) 话单数, 
	sum(case when CONVERSATION_EXPEND=0 then 0 else 1 end) as "接通数",
	sum(case when CONVERSATION_EXPEND=0 then 1 else 0 end) as "未接通数",
	CONCAT(ROUND(sum(case when CONVERSATION_EXPEND=0 then 0 else 1 end)/count(*)*100,2),'%') as "接通率",
	CONCAT(ROUND(sum(case when CONVERSATION_EXPEND=0 then 1 else 0 end)/count(*)*100,2),'%') as "未接通率",
	CONCAT(ROUND(sum(case when RELEASECAUSE=1 then 1 else 0 end)/count(*)*100,3),'%') as "未接通-1未应答",
	CONCAT(ROUND(sum(case when RELEASECAUSE=2 then 1 else 0 end)/count(*)*100,3),'%') as "未接通-2黑名单来电，拒接",
	CONCAT(ROUND(sum(case when RELEASECAUSE=3 then 1 else 0 end)/count(*)*100,3),'%') as "未接通-3虚号关机状态，未接听",
	CONCAT(ROUND(sum(case when RELEASECAUSE=4 then 1 else 0 end)/count(*)*100,3),'%') as "未接通-4无绑定呼叫",
	CONCAT(ROUND(sum(case when RELEASECAUSE=5 then 1 else 0 end)/count(*)*100,3),'%') as "未接通-5遇忙未接听",
	CONCAT(ROUND(sum(case when RELEASECAUSE=6 then 1 else 0 end)/count(*)*100,3),'%') as "未接通-6关系失效"
from SPN_CHARGING_ALL
where APPKEY='WBFCD'
-- and AREACODE = '020'
-- and tel_A = '17063320109'
and CREATEDTIME>to_date('2020-12-01 00:00:00','yyyy-mm-dd hh24-mi-ss')
and CREATEDTIME<to_date('2020-12-21 23:59:59','yyyy-mm-dd hh24-mi-ss')
GROUP BY to_char(CREATEDTIME,'yyyy-mm-dd')
ORDER BY 日期



观察58整体呼叫量
select  
	to_char(CREATEDTIME,'yyyy-mm-dd') 日期,  
-- 	count(*) 话单数, 
-- 	sum(case when CONVERSATION_EXPEND=0 then 0 else 1 end) as "接通数",
-- 	sum(case when CONVERSATION_EXPEND=0 then 1 else 0 end) as "未接通数",
-- 	CONCAT(ROUND(sum(case when CONVERSATION_EXPEND=0 then 0 else 1 end)/count(*)*100,2),'%') as "成都接通率",
-- 	CONCAT(ROUND(sum(case when CONVERSATION_EXPEND=0 then 1 else 0 end)/count(*)*100,2),'%') as "未接通率",
-- 	CONCAT(ROUND(sum(case when RELEASECAUSE=1 then 1 else 0 end)/count(*)*100,3),'%') as "未接通-1未应答",
-- 	CONCAT(ROUND(sum(case when RELEASECAUSE=2 then 1 else 0 end)/count(*)*100,3),'%') as "未接通-2黑名单来电，拒接",
-- 	CONCAT(ROUND(sum(case when RELEASECAUSE=3 then 1 else 0 end)/count(*)*100,3),'%') as "未接通-3虚号关机状态，未接听",
-- 	CONCAT(ROUND(sum(case when RELEASECAUSE=4 then 1 else 0 end)/count(*)*100,3),'%') as "未接通-4无绑定呼叫",
-- 	CONCAT(ROUND(sum(case when RELEASECAUSE=5 then 1 else 0 end)/count(*)*100,3),'%') as "未接通-5遇忙未接听",
-- 	CONCAT(ROUND(sum(case when RELEASECAUSE=6 then 1 else 0 end)/count(*)*100,3),'%') as "未接通-6关系失效"
from SPN_CHARGING_ALL
where APPKEY in ('WBBDF','WBZW','WBFC','HBVWBDC','WBFCN','WBSFC','WBFCD','WBZPD','WBTZ','')
-- and AREACODE = '025'
and CREATEDTIME>to_date('2019-09-25 00:00:00','yyyy-mm-dd hh24-mi-ss')
and CREATEDTIME<to_date('2020-10-10 23:59:59','yyyy-mm-dd hh24-mi-ss')
GROUP BY to_char(CREATEDTIME,'yyyy-mm-dd')
ORDER BY 日期



SELECT
		callid, tel_A, tel_X, tel_B, calltime,appkey,calltype
FROM 
		SPN_CHARGING_ALL
WHERE
		APPKEY = 'WBFCD'
		AND tel_A = '17063320109'
		AND CREATEDTIME BETWEEN to_date('2020-09-01 10:00:00','yyyy-mm-dd hh24-mi-ss') AND to_date('2020-09-25 10:09:59','yyyy-mm-dd hh24-mi-ss')




58房产接通率分析-通用模式
select  
	to_char(CREATEDTIME,'yyyy-mm-dd') 日期,  
-- 	appkey,
	count(*) 话单数,
-- 	sum(case when CONVERSATION_EXPEND=0 then 0 else 1 end) as "接通话单数",
-- 	sum(case when CONVERSATION_EXPEND=0 then 1 else 0 end) as "未接通话单数",
	sum(WITH_RECORD_COUNT) as "录音呼叫量（分钟）",
	sum(WITHOUT_RECORD_COUNT) as "不录音呼叫量（分钟）",
-- 	sum(CONVERSATION_EXPEND) as "总通话时长（秒）",
-- 	ROUND(sum(CONVERSATION_EXPEND)/sum(case when CONVERSATION_EXPEND=0 then 0 else 1 end),0) as "平均通话时长（秒）",
	CONCAT(ROUND(sum(case when CONVERSATION_EXPEND=0 then 0 else 1 end)/count(*)*100,3),'%') as "接通率",
-- 	CONCAT(ROUND(sum(case when CONVERSATION_EXPEND=0 then 1 else 0 end)/count(*)*100,3),'%') as "未接通率",
	CONCAT(ROUND(sum(case when RELEASECAUSE=127 then 1 else 0 end)/count(*)*100,2),'%') as "未接通-网络原因127",
	CONCAT(ROUND(sum(case when RELEASECAUSE=17 then 1 else 0 end)/count(*)*100,2),'%') as "未接通-用户忙17",
	CONCAT(ROUND(sum(case when RELEASECAUSE=18 then 1 else 0 end)/count(*)*100,2),'%') as "未接通-用户未响应18",
	CONCAT(ROUND(sum(case when RELEASECAUSE=19 then 1 else 0 end)/count(*)*100,2),'%') as "未接通-用户未应答19",
	CONCAT(ROUND(sum(case when RELEASECAUSE=20 then 1 else 0 end)/count(*)*100,2),'%') as "未接通-用户缺席20",
	CONCAT(ROUND(sum(case when (RELEASECAUSE=16 and CONVERSATION_EXPEND=0) then 1 else 0 end)/count(*)*100,3),'%') as "未接通-正常拆线16",
	CONCAT(ROUND(sum(case when (RELEASECAUSE=31 and CONVERSATION_EXPEND=0) then 1 else 0 end)/count(*)*100,3),'%') as "未接通-正常未指定31",
-- 	CONCAT(ROUND(sum(case when CALLTYPE=20 then 1 else 0 end)/count(*)*100,2),'%') as "无绑定呼叫calltype=20",
-- 	CONCAT(ROUND(sum(case when CALLTYPE=20 then 1 else 0 end)/count(*)*100,2),'%') as "无绑定呼叫calltype=20",
	CONCAT(ROUND(sum(case when (RELEASEDIR=1 and STARTTIME-RINGINGTIME=0 and CONVERSATION_EXPEND=0) then 1 else 0 end)/count(*)*100,2),'%') as "未接通-被叫振铃前主叫挂机",
	CONCAT(ROUND(sum(case when (RELEASEDIR=1 and STARTTIME-RINGINGTIME>0 and CONVERSATION_EXPEND=0) then 1 else 0 end)/count(*)*100,2),'%') as "未接通-被叫振铃后主叫挂机"
from SPN_CHARGING_ALL
where APPKEY in ('CNJS')
-- and sum(WITH_RECORD_COUNT)>0
-- and CONVERSATION_EXPEND > 0
-- and CALLRECORDING = 1
-- and AREACODE in ('028')
and CREATEDTIME>to_date('2020-12-01 00:00:00','yyyy-mm-dd hh24-mi-ss')
and CREATEDTIME<to_date('2020-12-24 23:35:59','yyyy-mm-dd hh24-mi-ss')
GROUP BY to_char(CREATEDTIME,'yyyy-mm-dd')
ORDER BY 日期


观察58整体呼叫量

select  
	to_char(CREATEDTIME,'yyyy-mm-dd') 日期,  count(*) 话单数,
	sum(case when CONVERSATION_EXPEND=0 then 0 else 1 end) as "接通数",
	sum(case when CONVERSATION_EXPEND=0 then 1 else 0 end) as "未接通数",
	sum(WITH_RECORD_COUNT) as "录音计费呼叫量",
	sum(WITHOUT_RECORD_COUNT) as "不录音计费呼叫量",
	CONCAT(ROUND(sum(case when CONVERSATION_EXPEND=0 then 0 else 1 end)/count(*)*100,3),'%') as "接通率"
-- 	CONCAT(ROUND(sum(case when CONVERSATION_EXPEND=0 then 1 else 0 end)/count(*)*100,3),'%') as "未接通率",
-- 	CONCAT(ROUND(sum(case when RELEASECAUSE=127 then 1 else 0 end)/count(*)*100,2),'%') as "未接通-网络原因127",
-- 	CONCAT(ROUND(sum(case when RELEASECAUSE=17 then 1 else 0 end)/count(*)*100,2),'%') as "未接通-用户忙17",
-- 	CONCAT(ROUND(sum(case when RELEASECAUSE=18 then 1 else 0 end)/count(*)*100,2),'%') as "未接通-用户忙18",
-- 	CONCAT(ROUND(sum(case when RELEASECAUSE=19 then 1 else 0 end)/count(*)*100,2),'%') as "未接通-用户未应答19",
-- 	CONCAT(ROUND(sum(case when RELEASECAUSE=20 then 1 else 0 end)/count(*)*100,2),'%') as "未接通-用户缺席20",
-- 	CONCAT(ROUND(sum(case when RELEASECAUSE=38 then 1 else 0 end)/count(*)*100,2),'%') as "未接通-无绑定呼叫38",
-- 	CONCAT(ROUND(sum(case when (RELEASECAUSE=16 and CONVERSATION_EXPEND=0) then 1 else 0 end)/count(*)*100,3),'%') as "未接通-正常拆线16",
-- 	CONCAT(ROUND(sum(case when (RELEASECAUSE=31 and CONVERSATION_EXPEND=0) then 1 else 0 end)/count(*)*100,3),'%') as "未接通-正常未指定31",
-- 	CONCAT(ROUND(sum(case when CALLTYPE=20 then 1 else 0 end)/count(*)*100,2),'%') as "无绑定呼叫calltype=20",
-- 	CONCAT(ROUND(sum(case when (RELEASEDIR=1 and STARTTIME-RINGINGTIME=0 and CONVERSATION_EXPEND=0) then 1 else 0 end)/count(*)*100,2),'%') as "未接通-被叫振铃前主叫挂机",
-- 	CONCAT(ROUND(sum(case when (RELEASEDIR=1 and STARTTIME-RINGINGTIME>0 and CONVERSATION_EXPEND=0) then 1 else 0 end)/count(*)*100,2),'%') as "未接通-被叫振铃后主叫挂机"
from SPN_CHARGING_ALL
where APPKEY in ('WBBDF','WBZW','WBFC','HBVWBDC','WBFCN','WBSFC','WBFCD','WBZPD','WBTZ','WBAJK','WBESC')
-- and AREACODE = '0531'
and CREATEDTIME>to_date('2019-09-25 09:29:00','yyyy-mm-dd hh24-mi-ss')
and CREATEDTIME<to_date('2019-10-10 23:35:59','yyyy-mm-dd hh24-mi-ss')
GROUP BY to_char(CREATEDTIME,'yyyy-mm-dd')
ORDER BY 日期




58黄页接通率分析-Sopen模式
select  
	to_char(CREATEDTIME,'yyyy-mm-dd') 日期,  count(*) 话单数, 
	sum(case when CALL_DURATION=0 then 0 else 1 end) as "接通数",
	sum(case when CALL_DURATION=0 then 1 else 0 end) as "未接通数",
	sum(WITH_RECORD_COUNT) as "呼叫量",
	CONCAT(ROUND(sum(case when CALL_DURATION=0 then 0 else 1 end)/count(*)*100,2),'%') as "接通率",
	CONCAT(ROUND(sum(case when CALL_DURATION=0 then 1 else 0 end)/count(*)*100,2),'%') as "未接通率"
-- 	CONCAT(ROUND(sum(case when RESULT='HANGUP' then 1 else 0 end)/count(*)*100,2),'%') as "主叫提前挂机-占比",
-- 	CONCAT(ROUND(sum(case when RESULT='OTHER' then 1 else 0 end)/count(*)*100,2),'%') as "其他失败情形-占比",
-- 	CONCAT(ROUND(sum(case when RESULT='NO_ANSWER' then 1 else 0 end)/count(*)*100,2),'%') as "被叫无应答-占比",
-- 	CONCAT(ROUND(sum(case when RESULT='REJECT' then 1 else 0 end)/count(*)*100,2),'%') as "被叫拒接-占比",
-- 	CONCAT(ROUND(sum(case when RESULT='NETWORK_ERROR' then 1 else 0 end)/count(*)*100,2),'%') as "网络限制-占比",
--   CONCAT(ROUND(sum(case when RESULT='ANSWERED' then 1 else 0 end)/count(*)*100,2),'%') as "RESULT==ANSWERED",
-- 	CONCAT(ROUND(sum(case when RESULT='BANNED' then 1 else 0 end)/count(*)*100,2),'%') as "RESULT==BANNED",
--   CONCAT(ROUND(sum(case when RESULT='NO_ANSWER' then 1 else 0 end)/count(*)*100,2),'%') as "RESULT==NO_ANSWER",
-- 	CONCAT(ROUND(sum(case when RESULT='POWER_OFF' then 1 else 0 end)/count(*)*100,2),'%') as "RESULT==POWER_OFF",
--   CONCAT(ROUND(sum(case when RESULT='HANGUP' then 1 else 0 end)/count(*)*100,2),'%') as "RESULT==HANGUP"
from SPN_LIANJIA_CALL_BILL_ALL
where APPKEY='WBHY_0001'
-- AND CALL_DURATION>0
and CREATEDTIME>to_date('2020-10-21 01:00:00','yyyy-mm-dd hh24-mi-ss')
and CREATEDTIME<to_date('2020-10-21 23:00:59','yyyy-mm-dd hh24-mi-ss')
GROUP BY to_char(CREATEDTIME,'yyyy-mm-dd')
ORDER BY 日期

统计network_error的占比
-- select  
-- 	to_char(CREATEDTIME,'yyyy-mm-dd') 日期,  count(*) 话单数, 
-- 	sum(case when RESULT = 'NETWORK_ERROR' then 1 else 0 end) as "NETWORK_ERROR数量",
-- 	CONCAT(ROUND(sum(case when RESULT = 'NETWORK_ERROR' then 1 else 0 end)/count(*)*100,2),'%') as "NETWORK_ERROR率",
-- 	sum(case when RESULT = 'OTHER' then 1 else 0 end) as "NETWORK_ERROR数量",
-- 	CONCAT(ROUND(sum(case when RESULT = 'OTHER' then 1 else 0 end)/count(*)*100,2),'%') as "OTHER率"
-- -- 	sum(case when RESULT = 'TP_ERROR' then 1 else 0 end) as "NETWORK_ERROR数量",
-- -- 	CONCAT(ROUND(sum(case when RESULT = 'TP_ERROR' then 1 else 0 end)/count(*)*100,2),'%') as "NETWORK_ERROR率"
-- from SPN_LIANJIA_CALL_BILL_ALL
-- where APPKEY in ('WBHY_0001')
-- -- AND CALL_DURATION>0
-- and CREATEDTIME>to_date('2020-09-01 00:00:00','yyyy-mm-dd hh24-mi-ss')
-- and CREATEDTIME<to_date('2020-10-16 23:59:59','yyyy-mm-dd hh24-mi-ss')
-- GROUP BY to_char(CREATEDTIME,'yyyy-mm-dd')
-- ORDER BY 日期


select  
	to_char(CREATEDTIME,'yyyy-mm') 日期,  count(*) 话单数, 
	sum(case when RESULT = 'NETWORK_ERROR' then 1 else 0 end) as "NETWORK_ERROR数量",
	CONCAT(ROUND(sum(case when RESULT = 'NETWORK_ERROR' then 1 else 0 end)/count(*)*100,2),'%') as "NETWORK_ERROR率",
	sum(case when RESULT = 'OTHER' then 1 else 0 end) as "NETWORK_ERROR数量",
	CONCAT(ROUND(sum(case when RESULT = 'OTHER' then 1 else 0 end)/count(*)*100,2),'%') as "OTHER率",
	sum(case when (CALLEE_NUM = '17800000000' AND RESULT = 'NETWORK_ERROR') then 1 else 0 end) as "17800000000数量",
	CONCAT(ROUND(sum(case when (CALLEE_NUM = '17800000000' AND RESULT = 'NETWORK_ERROR') then 1 else 0 end)/count(*)*100,2),'%') as "17800000000率"
-- 	sum(case when RESULT = 'TP_ERROR' then 1 else 0 end) as "NETWORK_ERROR数量",
-- 	CONCAT(ROUND(sum(case when RESULT = 'TP_ERROR' then 1 else 0 end)/count(*)*100,2),'%') as "NETWORK_ERROR率"
from SPN_LIANJIA_CALL_BILL_ALL
where APPKEY in ('WBHY_0001')
-- AND CALL_DURATION>0
and CREATEDTIME>to_date('2019-11-01 00:00:00','yyyy-mm-dd hh24-mi-ss')
and CREATEDTIME<to_date('2020-10-16 23:59:59','yyyy-mm-dd hh24-mi-ss')
GROUP BY to_char(CREATEDTIME,'yyyy-mm')
ORDER BY 日期


select 
CALLER_NUM,CALLEE_NUM,CALLER_SHOW_NUM,CALLEE_SHOW_NUM,START_TIME,ANSWER_TIME,END_TIME,PARTNER_CALL_ID,CALL_DURATION,RESULT
FROM SPN_LIANJIA_CALL_BILL_ALL
where appkey = 'WBHY_0001'
and result = 'NETWORK_ERROR'
and CREATEDTIME>to_date('2019-10-15 00:00:00','yyyy-mm-dd hh24-mi-ss')
and CREATEDTIME<to_date('2019-10-15 23:59:59','yyyy-mm-dd hh24-mi-ss')




运满满YMMBT接通率分析 - 定制化Sopen
select  
	to_char(CREATEDTIME,'yyyy-mm-dd hh24') 日期,  
	count(*) 话单数, 
	sum(case when CALL_DURATION=0 then 0 else 1 end) as "接通话单",
	sum(case when CALL_DURATION=0 then 1 else 0 end) as "未接通话单",
	sum(CALL_DURATION) as "总通话时长(秒)",
	ROUND(sum(CALL_DURATION)/sum(case when CALL_DURATION=0 then 0 else 1 end), 1) as "平均通话时长(秒)",
	sum(WITH_RECORD_COUNT) as "录音计费分钟数",
	CONCAT(ROUND(sum(case when CALL_DURATION=0 then 0 else 1 end)/count(*)*100,2),'%') as "接通率"
-- 	CONCAT(ROUND(sum(case when CALL_DURATION=0 then 1 else 0 end)/count(*)*100,2),'%') as "未接通率",
--   CONCAT(ROUND(sum(case when RESULT='ANSWERED' then 1 else 0 end)/count(*)*100,2),'%') as "RESULT==ANSWERED",
-- 	CONCAT(ROUND(sum(case when RESULT='BANNED' then 1 else 0 end)/count(*)*100,2),'%') as "RESULT==BANNED",
--   CONCAT(ROUND(sum(case when RESULT='NO_ANSWER' then 1 else 0 end)/count(*)*100,2),'%') as "RESULT==NO_ANSWER",
-- 	CONCAT(ROUND(sum(case when RESULT='BUSY' then 1 else 0 end)/count(*)*100,2),'%') as "RESULT==BUSY",
--   CONCAT(ROUND(sum(case when RESULT='HANGUP' then 1 else 0 end)/count(*)*100,2),'%') as "RESULT==HANGUP",
-- 	CONCAT(ROUND(sum(case when RESULT='SUSPEND' then 1 else 0 end)/count(*)*100,2),'%') as "RESULT==SUSPEND",
-- 	CONCAT(ROUND(sum(case when RESULT='TP_TIMEOUT' then 1 else 0 end)/count(*)*100,2),'%') as "RESULT==TP_TIMEOUT",
-- 	CONCAT(ROUND(sum(case when RESULT='TIMEOUT_RELEASE' then 1 else 0 end)/count(*)*100,2),'%') as "RESULT==TIMEOUT_RELEASE",
-- 	CONCAT(ROUND(sum(case when RESULT='REJECT' then 1 else 0 end)/count(*)*100,2),'%') as "RESULT==REJECT",
-- 	CONCAT(ROUND(sum(case when RESULT='OTHER' then 1 else 0 end)/count(*)*100,2),'%') as "RESULT==OTHER",
-- 	CONCAT(ROUND(sum(case when RESULT='POWER_OFF' then 1 else 0 end)/count(*)*100,2),'%') as "RESULT==POWER_OFF",
-- 	CONCAT(ROUND(sum(case when RESULT='INVALID_NUMBER' then 1 else 0 end)/count(*)*100,2),'%') as "RESULT==INVALID_NUMBER",
-- 	CONCAT(ROUND(sum(case when RESULT='UNAVAILABLE' then 1 else 0 end)/count(*)*100,2),'%') as "RESULT==UNAVAILABLE"
from SPN_LIANJIA_CALL_BILL_ALL
where APPKEY='YMMBT'
-- AND RESULT != 'BUSY'
and CREATEDTIME between to_date('2020-11-30 00:00:00','yyyy-mm-dd hh24-mi-ss') and to_date('2020-11-30 23:59:59','yyyy-mm-dd hh24-mi-ss')
GROUP BY to_char(CREATEDTIME,'yyyy-mm-dd hh24')
ORDER BY 日期


SELECT
*
FROM SPN_LIANJIA_CALL_BILL_ALL
where APPKEY='YMMBT'
and CREATEDTIME>to_date('2020-08-12 01:00:00','yyyy-mm-dd hh24-mi-ss')
and CREATEDTIME<to_date('2020-08-12 10:00:59','yyyy-mm-dd hh24-mi-ss')





顺丰接通率分析 - AXYG模式
select  
	to_char(CREATEDTIME,'yyyy-mm-dd') 日期,  
	count(*) 话单数,
	sum(case when DURATION=0 then 0 else 1 end) as "接通数",
	sum(case when DURATION=0 then 1 else 0 end) as "未接通数",
	sum(DURATION) as "总通话时长(秒)",
-- 	ROUND(sum(DURATION)/sum(case when DURATION=0 then 0 else 1 end), 0) as "平均通话时长(秒)",
	sum(CHARGEAMOUNT) as "计费分钟数",
	CONCAT(ROUND(sum(case when DURATION=0 then 0 else 1 end)/count(*)*100,3),'%') as "接通率"
from SPN_SF_CALL_BILL
where CREATEDTIME>to_date('2020-10-01 00:00:00','yyyy-mm-dd hh24-mi-ss')
and CREATEDTIME<to_date('2020-10-10 23:59:59','yyyy-mm-dd hh24-mi-ss')
GROUP BY to_char(CREATEDTIME,'yyyy-mm-dd')
ORDER BY 日期

统计单个号码使用情况
select  
NUMBER_Y, count(*) 话单数, sum(DURATION) 累计通话时长, sum(CHARGEAMOUNT) 累计计费次数
from SPN_SF_CALL_BILL
where CREATEDTIME>to_date('2020-09-22 00:00:00','yyyy-mm-dd hh24:mi:ss')
and CREATEDTIME<to_date('2020-09-27 23:59:59','yyyy-mm-dd hh24:mi:ss')
GROUP BY NUMBER_Y

SELECT *
FROM SPN_SF_CALL_BILL
WHERE CREATEDTIME>to_date('2020-10-07 00:00:00','yyyy-mm-dd hh24-mi-ss')
and CREATEDTIME<to_date('2020-10-08 23:59:59','yyyy-mm-dd hh24-mi-ss')



根据被叫运营商统计接通率
	select  
  to_char(CREATEDTIME,'yyyy-mm-dd') 日期,
  case when CALLTYPE = '10' THEN TEL_B 
			 when CALLTYPE = '11' THEN TEL_A  
			 when CALLTYPE = '21' THEN TEL_A end 
			 as 被叫,
	case when CONVERSATION_EXPEND>0 then 1 else 0 end as "是否接通",
	
	from SPN_CHARGING_ALL
	where APPKEY  in ('WBFC')
	and CONVERSATION_EXPEND>0
and CALLTYPE = '10'
and CREATEDTIME>to_date('2019-06-14 20:00:05' ,'yyyy-mm-dd hh24:mi:ss')
and CREATEDTIME<to_date('2019-06-14 23:59:59' ,'yyyy-mm-dd hh24:mi:ss')
GROUP BY TEL_B
ORDER BY 接通次数


统计168,169,170,录音桥接失败的
	select  
		to_char(CREATEDTIME,'yyyy-mm-dd') 日期,
		APPKEY,
		count(1) releasecause170数量
-- 			*
	from SPN_CHARGING_ALL
	where 
-- 	APPKEY  in ('WBFC'，'WBSFC')
	RELEASECAUSE = '170' 
	and CONVERSATION_EXPEND > '1'
	and CALLRECORDING = '1'
	and CREATEDTIME>to_date('2020-08-01 00:00:05' ,'yyyy-mm-dd hh24:mi:ss')
	and CREATEDTIME<to_date('2020-08-21 23:59:59' ,'yyyy-mm-dd hh24:mi:ss')
	GROUP BY to_char(CREATEDTIME,'yyyy-mm-dd'),APPKEY
	ORDER BY 日期
	

	
号码使用率
	select 
		to_char(CREATEDTIME,'yyyy-mm-dd') 日期,
		ROUND(count(DISTINCT(TEL_X))/10202, 2)
	from SPN_CHARGING_ALL
	WHERE 
		appkey = 'WBAJK'
		and CREATEDTIME>to_date('2020-06-01 00:00:05' ,'yyyy-mm-dd hh24:mi:ss')
		and CREATEDTIME<to_date('2020-06-22 23:59:59' ,'yyyy-mm-dd hh24:mi:ss')
	GROUP BY to_char(CREATEDTIME,'yyyy-mm-dd')
	ORDER BY 日期



优居导详单
select 
-- sum(WITH_RECORD_COUNT)
APPKEY,STARTTIME,RELEASETIME,TEL_A,TEL_X,TEL_B,CONVERSATION_EXPEND,WITH_RECORD_COUNT,WITHOUT_RECORD_COUNT,CALLTYPE
from SPN_CHARGING_ALL
where APPKEY in ('YJYZA')
-- where APPKEY in ('WBXX')
-- and CALLRECORDING = 1
-- and TEL_A = '02131771712'
-- and TEL_B = '18645828118'
-- and TEL_X in ('15632613461','15632614457')
and CONVERSATION_EXPEND > 0
and CREATEDTIME>to_date('2020-11-01 00:00:00' ,'yyyy-mm-dd hh24:mi:ss')
and CREATEDTIME<to_date('2020-11-30 23:59:59' ,'yyyy-mm-dd hh24:mi:ss')


普通导话单
select 
*
-- count(1)
-- sum(WITH_RECORD_COUNT)
-- APPKEY,STARTTIME,RELEASETIME,TEL_A,TEL_X,TEL_B,callid,CONVERSATION_EXPEND,WITH_RECORD_COUNT,WITHOUT_RECORD_COUNT,CREATEDTIME,RECORD_URL,CALLTYPE,RELEASECAUSE,CALLRECORDING,SUBID
from SPN_CHARGING_ALL
where APPKEY in ('WBFCD')
-- and CALLRECORDING = 1
-- and TEL_A = '13506111635'
-- and TEL_B in ('13025126546','13155505283','18666014340','13794381831','13155505283','13356889179','13794381831','13155505283','13533613635','13927233357','13922100824','13710195828','18816801415','13726700133','13711749106')
-- and subid = 'e6e9615244bb47dba394379c4e905504'
-- and RELEASECAUSE in ('17')
and CREATEDTIME>to_date('2020-12-22 09:00:00' ,'yyyy-mm-dd hh24:mi:ss')
and CREATEDTIME<to_date('2020-12-22 12:00:00' ,'yyyy-mm-dd hh24:mi:ss')



统计单个号码使用情况
select  
TEL_X, count(*) 话单数, sum(CONVERSATION_EXPEND) 累计通话时长, sum(WITH_RECORD_COUNT) 累计录音计费次数, sum(WITHOUT_RECORD_COUNT) 累计不录音计费次数
from SPN_CHARGING_ALL
where CREATEDTIME>to_date('2021-01-01 00:00:00','yyyy-mm-dd hh24:mi:ss')
and CREATEDTIME<to_date('2021-03-12 23:59:59','yyyy-mm-dd hh24:mi:ss')
and appkey in ('WBESC','HBVWBESC')
GROUP BY TEL_X


Sopen话单
select  
CREATEDTIME,START_TIME,ANSWER_TIME,END_TIME,RESULT,RELEASE_DIRECTION,CALLER_NUM,CALLEE_SHOW_NUM,CALLEE_NUM,CALL_DURATION,SOUND_URL,PARTNER_CALL_ID
-- *
from SPN_LIANJIA_CALL_BILL
where  APPKEY='WBHY_0001'
-- and CALL_DURATION>0
and CREATEDTIME between to_date('2020-11-09 00:00:00' ,'yyyy-mm-dd hh24:mi:ss') and to_date('2020-11-11 23:29:59' ,'yyyy-mm-dd hh24:mi:ss')
-- and CALLEE_SHOW_NUM  = '17075192987'
-- and  PARTNER_CALL_ID in ('415f8fea77621951')
AND CALLEE_NUM in ('02156051117')



表
Sopen短信表：SPN_LIANJIA_SMS_RECORD
通用模式短信表：SPN_SMS_CHARGING
美团话单表：SPN_MTWM_CALL_BILL, SPN_MTWM_CALL_BILL_BJ
重推表：SPN_PUSH_RETRY
翟龙龙的表：P_REGISTRATION_LOCATION
码号系统的表：T_PHONE_NUMBER_DETAIL

短信数



按小时统计：to_char(CREATEDTIME,'yyyy-mm-dd hh24') 日期



多表操作来一波
需求：WBFCD的话单没有区号，那就把话单里A、X、B三个号码的省份和区号都加上


select 
		CALLID, TEL_A, TEL_X, TEL_B, 
		P_REGISTRATION_LOCATION.AREACODE , P_REGISTRATION_LOCATION.CITY
from 
		SPN_CHARGING_ALL
left join
		P_REGISTRATION_LOCATION
on
		SUBSTR(SPN_CHARGING_ALL.TEL_X, 1, 7) = P_REGISTRATION_LOCATION.MOBILE
where
		APPKEY in ('WBFCD')
and
		SPN_CHARGING_ALL.CREATEDTIME between to_date('2020-09-27 10:00:00' ,'yyyy-mm-dd hh24:mi:ss') and to_date('2020-09-27 10:29:59' ,'yyyy-mm-dd hh24:mi:ss')
		
		
导出欧阳的号码清单
SELECT
	*
FROM
-- 	T_PHONE_NUMBER_DETAIL
	T_PHONE_TOTAL
WHERE
	APPKEY='LSYG'
-- 	CREATOR_ID='linlinli'


58二手房的奇葩数据需求
select  
	to_char(CREATEDTIME,'yyyy-mm-dd') 日期,  
	count(*) 总话单,
	sum(case when CALLTYPE=20 then 0 else 1 end) as "有效呼叫量-不含无绑定话单",
	sum(case when CONVERSATION_EXPEND=0 then 0 else 1 end) as "接通量",
	CONCAT(ROUND(sum(case when CONVERSATION_EXPEND=0 then 0 else 1 end)/sum(case when CALLTYPE=20 then 0 else 1 end)*100,3),'%') as "接通率",
	sum(case when CALLTYPE=20 then 1 else 0 end) as "无绑定关系",
	CONCAT(ROUND(sum(case when CALLTYPE=20 then 1 else 0 end)/count(*)*100,2),'%') as "无绑定呼叫-占比",
	sum(case when (RELEASEDIR=1 and STARTTIME-RINGINGTIME=0 and CONVERSATION_EXPEND=0 and RELEASECAUSE!=17) then 1 else 0 end) as "被叫振铃前主叫挂机",
	CONCAT(ROUND(sum(case when (RELEASEDIR=1 and STARTTIME-RINGINGTIME=0 and CONVERSATION_EXPEND=0 and RELEASECAUSE!=17) then 1 else 0 end)/count(*)*100,2),'%') as "被叫振铃前主叫挂机-占比",
	sum(case when (RELEASEDIR=1 and STARTTIME-RINGINGTIME>0 and CONVERSATION_EXPEND=0 and RELEASECAUSE!=17) then 1 else 0 end) as "被叫振铃后主叫挂机",
	CONCAT(ROUND(sum(case when (RELEASEDIR=1 and STARTTIME-RINGINGTIME>0 and CONVERSATION_EXPEND=0 and RELEASECAUSE!=17) then 1 else 0 end)/count(*)*100,2),'%') as "被叫振铃后主叫挂机-占比",
	sum(case when RELEASECAUSE=127 then 1 else 0 end) as "网络原因",
	CONCAT(ROUND(sum(case when RELEASECAUSE=127 then 1 else 0 end)/count(*)*100,2),'%') as "网络原因-占比",
	sum(case when RELEASECAUSE=17 then 1 else 0 end) as "被叫忙",
	CONCAT(ROUND(sum(case when RELEASECAUSE=17 then 1 else 0 end)/count(*)*100,2),'%') as "被叫忙-占比",
	sum(case when RELEASECAUSE=19 or RELEASECAUSE=18 then 1 else 0 end) as "被叫未应答",
	CONCAT(ROUND(sum(case when RELEASECAUSE=19 or RELEASECAUSE=18 then 1 else 0 end)/count(*)*100,2),'%') as "被叫未应答-占比",
	sum(case when (RELEASEDIR=2 and STARTTIME-RINGINGTIME>0 and CONVERSATION_EXPEND=0 and RELEASECAUSE!=17) then 1 else 0 end) as "被叫拒接",
	CONCAT(ROUND(sum(case when (RELEASEDIR=2 and STARTTIME-RINGINGTIME>0 and CONVERSATION_EXPEND=0 and RELEASECAUSE!=17) then 1 else 0 end)/count(*)*100,2),'%') as "被叫拒接-占比",
	sum(case when RELEASECAUSE=20 then 1 else 0 end) as "被叫关机",
	CONCAT(ROUND(sum(case when RELEASECAUSE=20 then 1 else 0 end)/count(*)*100,2),'%') as "被叫关机-占比"
from SPN_CHARGING_ALL
where APPKEY in ('WBBDF')
		and CREATEDTIME>to_date('2020-12-09 00:00:00','yyyy-mm-dd hh24-mi-ss')
		and CREATEDTIME<to_date('2020-12-16 23:35:59','yyyy-mm-dd hh24-mi-ss')
GROUP BY to_char(CREATEDTIME,'yyyy-mm-dd')
ORDER BY 日期


58采购的奇葩需求: 普通模式
select  
	to_char(CREATEDTIME,'yyyy-mm') 日期,  
	appkey,
	count(*) 话单数,
	sum(case when CONVERSATION_EXPEND=0 then 1 else 0 end) as "未接通话单数",
	sum(case when CONVERSATION_EXPEND=0 then 0 else 1 end) as "接通话单数",
	CONCAT(ROUND(sum(case when CONVERSATION_EXPEND=0 then 0 else 1 end)/count(*)*100,3),'%') as "接通率",
	sum(WITH_RECORD_COUNT) as "录音呼叫量（分钟）",
	sum(WITHOUT_RECORD_COUNT) as "不录音呼叫量（分钟）",
	sum(case when RELEASECAUSE=17 then 1 else 0 end) as "未接通-用户通话中",
	CONCAT(ROUND(sum(case when RELEASECAUSE=17 then 1 else 0 end)/count(*)*100,2),'%') as "未接通占比-用户通话中",
	sum(case when (RELEASEDIR=2 and STARTTIME-RINGINGTIME>0 and CONVERSATION_EXPEND=0) then 1 else 0 end) as "未接通-被叫拒接",
	CONCAT(ROUND(sum(case when (RELEASEDIR=2 and STARTTIME-RINGINGTIME>0 and CONVERSATION_EXPEND=0) then 1 else 0 end)/count(*)*100,2),'%') as "未接通占比-被叫拒接",
	sum(case when (RELEASEDIR=1 and STARTTIME-RINGINGTIME>0 and CONVERSATION_EXPEND=0) then 1 else 0 end) as "未接通-被叫振铃后主叫挂机",
	CONCAT(ROUND(sum(case when (RELEASEDIR=1 and STARTTIME-RINGINGTIME>0 and CONVERSATION_EXPEND=0) then 1 else 0 end)/count(*)*100,2),'%') as "未接通-被叫振铃后主叫挂机"
from SPN_CHARGING_ALL
where APPKEY in ('WBTC','WBCS','WBZP','WBFC','WBFCT','WBESC','AJCS','AJPT','WBEST','WBZPD','WBZF','WBZTT','WBZT','CSGC','CSDD','WBZW','WBFCD','WBTZ','WBTZ_0001','FCSX_0001','JXEDT','WBXA','WBFCN','ESCCS','WBXC','WBXX','SIP','WBSIP','WBCHE','HYSIP','ZPYY','ZPYH','ZPZZ','ZPKF','SLGXC','WBSFC','AJKXF','LNVWBHJ','LNVWBJR','LNVWBZX','LNVWBGYX','LNVAJK','LNVWBTZXC','WBBDF','WBAJK','HBVWBHJ','HBVWBHJT','HBVWBDC','HBVWBESCT','WBDKF','HBVWBCHE','HBVWBESC','HBVWBFCN','HBVWBGJ','HBVHYSIP','HBVWBBX','HBVWBBXN','HBVWBBXB','LNVWBHY','WBZPT','LNVWBXX','WBHJT','WBHJ','WBSPT','WBFZX','WBYYM','WBAJKS','WBXAN','WBLJTX','WBGYAXB','WBAXY','WBAXG','WBSZ','WBXT','WBAJKE','WBZS','AJKSZ','WBXCN','WBXCA')
and CREATEDTIME>to_date('2020-01-01 00:00:00','yyyy-mm-dd hh24-mi-ss')
and CREATEDTIME<to_date('2020-12-25 23:59:59','yyyy-mm-dd hh24-mi-ss')
GROUP BY to_char(CREATEDTIME,'yyyy-mm'),appkey
ORDER BY 日期,appkey


Sopen模式
select  
	to_char(CREATEDTIME,'yyyy-mm') 日期,
	appkey,
	count(*) 总话单数, 
	sum(case when CALL_DURATION=0 then 1 else 0 end) as "未接通数",
	sum(case when CALL_DURATION=0 then 0 else 1 end) as "接通数",
	CONCAT(ROUND(sum(case when CALL_DURATION=0 then 0 else 1 end)/count(*)*100,2),'%') as "接通率",
	sum(WITH_RECORD_COUNT) as "录音呼叫量（分钟）",
	sum(WITHOUT_RECORD_COUNT) as "不录音呼叫量（分钟）",
	sum(case when RESULT='BUSY' then 1 else 0 end) as "被叫忙",
	CONCAT(ROUND(sum(case when RESULT='BUSY' then 1 else 0 end)/count(*)*100,2),'%') as "被叫忙-占比",
	sum(case when RESULT='REJECT' then 1 else 0 end) as "被叫拒接",
	CONCAT(ROUND(sum(case when RESULT='REJECT' then 1 else 0 end)/count(*)*100,2),'%') as "被叫拒接-占比",
	sum(case when RESULT='HANGUP' then 1 else 0 end) as "主叫提前挂机",
	CONCAT(ROUND(sum(case when RESULT='HANGUP' then 1 else 0 end)/count(*)*100,2),'%') as "主叫提前挂机-占比"
from SPN_LIANJIA_CALL_BILL_ALL
where APPKEY in ('WBGY_0001','WBHY_0001')
and CREATEDTIME>to_date('2020-01-01 01:00:00','yyyy-mm-dd hh24-mi-ss')
and CREATEDTIME<to_date('2020-12-22 23:59:59','yyyy-mm-dd hh24-mi-ss')
GROUP BY to_char(CREATEDTIME,'yyyy-mm'),appkey
ORDER BY 日期,appkey







