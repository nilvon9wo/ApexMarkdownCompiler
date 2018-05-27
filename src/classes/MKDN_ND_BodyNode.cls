public class MKDN_ND_BodyNode extends MKDN_ND_Node {
    public List<MKDN_ND_Node> paragraphList {get; private set;}
    
    public MKDN_ND_BodyNode(List<MKDN_ND_Node> paragraphList, Integer consumed) {
    	this.paragraphList = paragraphList;
    	this.nodeType = MKDN_ND_NodeTypeEnum.BODY;
    	this.consumed = consumed;
    }
}