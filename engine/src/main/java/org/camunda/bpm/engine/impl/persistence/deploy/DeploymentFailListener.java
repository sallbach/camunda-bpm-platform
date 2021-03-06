/* Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.camunda.bpm.engine.impl.persistence.deploy;

import java.util.Collections;
import java.util.Set;

import org.camunda.bpm.engine.impl.cfg.TransactionListener;
import org.camunda.bpm.engine.impl.cmd.UnregisterDeploymentCmd;
import org.camunda.bpm.engine.impl.interceptor.CommandContext;

public class DeploymentFailListener implements TransactionListener {

  protected Set<String> deploymentIds;

  public DeploymentFailListener(String deploymentId) {
    this.deploymentIds = Collections.singleton(deploymentId);
  }

  public DeploymentFailListener(Set<String> deploymentIds) {
    this.deploymentIds = deploymentIds;
  }

  public void execute(CommandContext commandContext) {
    new UnregisterDeploymentCmd(deploymentIds).execute(commandContext);
  }

}
