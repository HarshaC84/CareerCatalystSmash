@isTest  
public class RecursiveTests {

    @isTest
    static void testRecursive() {

        system.assert(ProposalUpdate.runOnce());
        system.assert(!ProposalUpdate.runOnce());
    }
}