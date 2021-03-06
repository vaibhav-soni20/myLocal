//Generated by wsdl2apex

public class AsyncSoapSforceComSchemasClassAccountpla {
    public class createAccountPlanResponse_elementFuture extends System.WebServiceCalloutFuture {
        public String getValue() {
            soapSforceComSchemasClassAccountpla.createAccountPlanResponse_element response = (soapSforceComSchemasClassAccountpla.createAccountPlanResponse_element)System.WebServiceCallout.endInvoke(this);
            return response.result;
        }
    }
    public class AsyncAccountPlan {
        public String endpoint_x = 'https://ap5.salesforce.com/services/Soap/class/AccountPlan';
        public Map<String,String> inputHttpHeaders_x;
        public String clientCertName_x;
        public Integer timeout_x;
        public soapSforceComSchemasClassAccountpla.AllowFieldTruncationHeader_element AllowFieldTruncationHeader;
        public soapSforceComSchemasClassAccountpla.SessionHeader_element SessionHeader;
        public soapSforceComSchemasClassAccountpla.CallOptions_element CallOptions;
        public soapSforceComSchemasClassAccountpla.DebuggingInfo_element DebuggingInfo;
        public soapSforceComSchemasClassAccountpla.DebuggingHeader_element DebuggingHeader;
        private String AllowFieldTruncationHeader_hns = 'AllowFieldTruncationHeader=http://soap.sforce.com/schemas/class/AccountPlan';
        private String SessionHeader_hns = 'SessionHeader=http://soap.sforce.com/schemas/class/AccountPlan';
        private String CallOptions_hns = 'CallOptions=http://soap.sforce.com/schemas/class/AccountPlan';
        private String DebuggingInfo_hns = 'DebuggingInfo=http://soap.sforce.com/schemas/class/AccountPlan';
        private String DebuggingHeader_hns = 'DebuggingHeader=http://soap.sforce.com/schemas/class/AccountPlan';
        private String[] ns_map_type_info = new String[]{'http://soap.sforce.com/schemas/class/AccountPlan', 'soapSforceComSchemasClassAccountpla'};
        public AsyncSoapSforceComSchemasClassAccountpla.createAccountPlanResponse_elementFuture beginCreateAccountPlan(System.Continuation continuation) {
            soapSforceComSchemasClassAccountpla.createAccountPlan_element request_x = new soapSforceComSchemasClassAccountpla.createAccountPlan_element();
            return (AsyncSoapSforceComSchemasClassAccountpla.createAccountPlanResponse_elementFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncSoapSforceComSchemasClassAccountpla.createAccountPlanResponse_elementFuture.class,
              continuation,
              new String[]{endpoint_x,
              '',
              'http://soap.sforce.com/schemas/class/AccountPlan',
              'createAccountPlan',
              'http://soap.sforce.com/schemas/class/AccountPlan',
              'createAccountPlanResponse',
              'soapSforceComSchemasClassAccountpla.createAccountPlanResponse_element'}
            );
        }
    }
}